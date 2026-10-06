-- Generated from ChapterA3i.lean — theorem BookProof.ChapterA3.spinor_inv_eq
import Mathlib
import Definitions.Def_ChapterA3i
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.spinor_inv_eq (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    (Spinor T)⁻¹ = SpinorInv T := by sorry
