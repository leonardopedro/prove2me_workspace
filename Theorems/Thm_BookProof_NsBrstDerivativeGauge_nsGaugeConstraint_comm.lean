-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.nsGaugeConstraint_comm
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.nsGaugeConstraint_comm (j k : Fin 3) :
    nsGaugeConstraint j * nsGaugeConstraint k = nsGaugeConstraint k * nsGaugeConstraint j := by sorry
