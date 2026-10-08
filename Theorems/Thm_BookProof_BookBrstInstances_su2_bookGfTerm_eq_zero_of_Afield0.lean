-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_bookGfTerm_eq_zero_of_Afield0
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


theorem BookProof.BookBrstInstances.su2_bookGfTerm_eq_zero_of_Afield0 (x : Fin 4 → Fin 3 → ℝ)
    (hA0 : ∀ a : Fin 3, Afield (N := 3) 0 a = 0) :
    bookGfTerm (su2BookAlgebra x) = 0 := by sorry
