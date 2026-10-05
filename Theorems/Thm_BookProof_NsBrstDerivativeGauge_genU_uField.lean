-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.genU_uField
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

theorem BookProof.NsBrstDerivativeGauge.genU_uField (m j : Fin 3) : genU m (uField j) = if m = j then 1 else 0 := by sorry
