-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bookOmega_eq_brstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.SmBrstGhost
open BookProof.YangMillsGhost
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.bookOmega_eq_brstCharge :
    bookOmega G = Complex.I • brstCharge G.f (gaussGen G) chiOp betaOp := by sorry
