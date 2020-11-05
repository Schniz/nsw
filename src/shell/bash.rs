use super::shell::Shell;
use indoc::indoc;
use std::path::PathBuf;

#[derive(Debug)]
pub struct Bash;

impl Shell for Bash {
    fn into_structopt_shell(&self) -> structopt::clap::Shell {
        structopt::clap::Shell::Bash
    }

    fn path(&self, path: &PathBuf) -> String {
        format!("export PATH={:?}:$PATH", path.to_str().unwrap())
    }

    fn set_env_var(&self, name: &str, value: &str) -> String {
        format!("export {}={:?}", name, value)
    }

    fn use_on_cd(&self, _config: &crate::config::FnmConfig) -> String {
        indoc!(
            r#"
                __fnmcd () {
                    cd "$@"
                    
                    if [ -s .node-version ] || [ -s .nvmrc ]; then
                        fnm use
                    else
                        fnm use default
                    fi
                }

                alias cd=__fnmcd
            "#
        )
        .into()
    }
}
