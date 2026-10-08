-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bookOmega_eq_brstCharge
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.YangMillsGhost
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.bookOmega_eq_brstCharge :
    bookOmega G = Complex.I • brstCharge G.f (gaussGen G) chiOp betaOp := by sorry
