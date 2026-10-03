-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.Afield_comm_chi
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.YangMillsGhost

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.Afield_comm_chi (μ : Fin 4) (a b : Fin N) :
    Afield (N := N) μ a * chiOp b = chiOp b * Afield μ a := by sorry
