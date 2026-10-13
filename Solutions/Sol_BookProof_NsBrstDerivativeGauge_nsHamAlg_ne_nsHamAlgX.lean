-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsHamAlg_ne_nsHamAlgX
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsHamAlgX_one
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsHamAlg_one_ne_zero
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.NavierStokesGaugeY

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) : nsHamAlg nu ≠ nsHamAlgX nu := by

  intro h
  refine nsHamAlg_one_ne_zero nu ?_
  rw [h, nsHamAlgX_one]
