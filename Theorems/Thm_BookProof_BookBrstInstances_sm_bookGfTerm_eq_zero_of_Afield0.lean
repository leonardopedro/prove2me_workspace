-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.sm_bookGfTerm_eq_zero_of_Afield0
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsGhost
open BookProof.BookBrstInstances



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)


theorem BookProof.BookBrstInstances.sm_bookGfTerm_eq_zero_of_Afield0 (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ)
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c) (h3cyc : ∀ a b c, f3 a b c = f3 b c a)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0)
    (x : Fin 4 → Fin 12 → ℝ)
    (hA0 : ∀ a : Fin 12, Afield (N := 12) 0 a = 0) :
    bookGfTerm (smBookAlgebra f3 h3anti h3cyc h3jac x) = 0 := by sorry
