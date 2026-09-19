-- Generated from ChapterYangMillsSU3.lean — theorem BookProof.YangMillsSU3.structureConstant_antisymm_rotate
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
open BookProof.YangMillsSU3

variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)


open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)

theorem BookProof.YangMillsSU3.structureConstant_antisymm_rotate
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c : Fin d) :
    f a b c = - f a c b := by sorry
