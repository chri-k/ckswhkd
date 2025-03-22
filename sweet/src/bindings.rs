use std::fmt::Display;

use crate::{Definition, Instruction};

#[derive(Debug, PartialEq, Eq)]
pub struct Binding {
    pub definition: Definition,
    pub instructions: Vec<Instruction>,
}

impl Binding {
    pub fn running<S: AsRef<str>>(command: S) -> BindingBuilder {
        BindingBuilder {
            command: command.as_ref().to_string(),
        }
    }
}

pub struct BindingBuilder {
    pub command: String,
}

impl BindingBuilder {
    pub fn on(self, definition: Definition) -> Binding {
        Binding {
            definition,
            instructions: vec![],
        }
    }
}

impl Display for Binding {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "Binding {} \u{2192} instructions: {:?}",
            self.definition, self.instructions
        )
    }
}
