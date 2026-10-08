-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.bookGfTerm_eq
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.SmBrstGhost
open BookProof.YangMillsGhost
open BookProof.BookBrstGaugeFixing



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstGaugeFixing.bookGfTerm_eq :
    bookGfTerm G
      = -((∑ c, gaussGen G c * Afield 0 c)
          - (∑ c, ∑ d, (gaussGen G c * Afield 0 d - Afield 0 d * gaussGen G c)
              * (betaOp d * chiOp c))
          - ∑ a, ∑ b, ∑ c, G.f a b c • (Afield 0 a * (chiOp b * betaOp c))) := by sorry
