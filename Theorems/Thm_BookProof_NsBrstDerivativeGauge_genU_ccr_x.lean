-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.genU_ccr_x
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.genU_ccr_x (i k : Fin 3) (p : NSAlg) :
    genU i (X (NSVar.x k) * p) - X (NSVar.x k) * genU i p = 0 := by sorry
