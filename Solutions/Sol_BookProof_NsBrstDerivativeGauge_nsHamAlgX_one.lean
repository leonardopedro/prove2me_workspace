-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsHamAlgX_one
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NavierStokesGaugeY_genX_nsSymbol
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.ChapterF7
open BookProof.NavierStokesGaugeY

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) : nsHamAlgX nu 1 = 0 := by

  rw [nsHamAlgX, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun i _ => ?_
  have h1 : (genX i * BookProof.NsBrstDerivativeGauge.mulOp (nsSymbol nu i)) 1 = 0 := by
    rw [Module.End.mul_apply, BookProof.NsBrstDerivativeGauge.mulOp, LinearMap.mulLeft_apply, mul_one, genX_nsSymbol]
  have h2 : (BookProof.NsBrstDerivativeGauge.mulOp (nsSymbol nu i) * genX i) 1 = 0 := by
    rw [Module.End.mul_apply, genX_apply]
    simp [BookProof.NsBrstDerivativeGauge.mulOp]
  rw [LinearMap.add_apply, h1, h2, add_zero]
