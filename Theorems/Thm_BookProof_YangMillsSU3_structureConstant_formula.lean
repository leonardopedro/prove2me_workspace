-- Generated from ChapterYangMillsSU3.lean — theorem BookProof.YangMillsSU3.structureConstant_formula
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
open BookProof.YangMillsSU3







open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

theorem BookProof.YangMillsSU3.structureConstant_formula
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b d : Fin d) :
    (f a b d : ℂ) = -2 * Complex.I * ((T a * T b - T b * T a) * T d).trace := by sorry
