-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.nsGaugeConstraint2_comm
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.nsGaugeConstraint2_comm (j k : Fin 3) :
    nsGaugeConstraint2 j * nsGaugeConstraint2 k
      = nsGaugeConstraint2 k * nsGaugeConstraint2 j := by sorry
