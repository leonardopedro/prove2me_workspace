-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bosOpN_sum
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.YangMillsGhost

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.bosOpN_sum {n : ℕ} (T : Fin n → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ e, T e) = ∑ e, bosOpN (T e) := by sorry
