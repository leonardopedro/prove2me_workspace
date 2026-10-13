-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsGhost_car
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.BRSTNilpotent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : GhostCAR nsGhostCre nsGhostAnn := by

  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [nsGhostCre, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [nsGhostAnn, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [nsGhostCre, nsGhostAnn, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]
