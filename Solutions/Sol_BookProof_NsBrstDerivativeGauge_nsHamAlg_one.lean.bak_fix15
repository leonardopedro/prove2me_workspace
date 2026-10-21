-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsHamAlg_one
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_nsSymbol
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_apply
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) : nsHamAlg nu 1 = ∑ i : Fin 3, X (NSVar.uD i i) := by

  rw [nsHamAlg, LinearMap.sum_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  have h1 : (genU i * mulOp (nsSymbol nu i)) 1 = X (NSVar.uD i i) := by
    rw [Module.End.mul_apply, mulOp, LinearMap.mulLeft_apply, mul_one, genU_nsSymbol]
  have h2 : (mulOp (nsSymbol nu i) * genU i) 1 = 0 := by
    rw [Module.End.mul_apply, genU_apply]
    simp [mulOp]
  rw [LinearMap.add_apply, h1, h2, add_zero]
