-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bosOpN_mul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsGhost
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.bosOpN_mul (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S * T) = bosOpN S * bosOpN T := by sorry
