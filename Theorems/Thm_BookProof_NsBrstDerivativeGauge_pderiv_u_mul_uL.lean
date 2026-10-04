-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.pderiv_u_mul_uL
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.pderiv_u_mul_uL (m i : Fin 3) (q : NSAlg) :
    pderiv (NSVar.u m) (X (NSVar.uL i) * q) = X (NSVar.uL i) * pderiv (NSVar.u m) q := by sorry
