-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bookCCR
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.YangMillsGhost

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.bookCCR (μ ν : Fin 4) (a b : Fin N) :
    Afield μ a * mom ν b - mom ν b * Afield μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (BookState N)) else 0 := by sorry
