-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.sp_swap12
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
open BookProof.BookBrstInstances

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section


theorem BookProof.BookBrstInstances.sp_swap12 (hanti : ∀ a b c, f a b c = -f b a c) (p q r s : Fin N) :
    sp f p q r s = -sp f q p r s := by sorry
