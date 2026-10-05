-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.ghostOpN_mul
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

theorem BookProof.BookBrstYangMills.ghostOpN_mul (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S * T) = ghostOpN S * ghostOpN T := by sorry
