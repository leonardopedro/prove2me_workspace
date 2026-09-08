-- Generated from ChapterYangMillsSU3.lean — theorem BookProof.YangMillsSU3.structureConstant_totally_antisymmetric
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
open BookProof.YangMillsSU3







open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

theorem BookProof.YangMillsSU3.structureConstant_totally_antisymmetric
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f) :
    (∀ a b c, f a b c = - f b a c) ∧ (∀ a b c, f a b c = - f a c b) := by sorry
