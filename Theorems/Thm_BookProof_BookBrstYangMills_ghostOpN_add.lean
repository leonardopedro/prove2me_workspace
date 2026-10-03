-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.ghostOpN_add
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.YangMillsGhost

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.ghostOpN_add (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S + T) = ghostOpN S + ghostOpN T := by sorry
