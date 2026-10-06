-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.latticeLagCLM_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_isSelfAdjoint
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) (nu : ℝ) :
    IsSelfAdjoint (latticeLagCLM v w fr nu) := by

  have hmom : IsSelfAdjoint (momentum * momentum) := by
    change star (momentum * momentum) = momentum * momentum
    rw [star_mul, momentum_isSelfAdjoint.star_eq]
  have hsum : IsSelfAdjoint (∑ _i : Fin 3, momentum * momentum) := by
    change star _ = _
    rw [star_sum]
    exact Finset.sum_congr rfl fun i _ => hmom.star_eq
  have hreal : ∀ (r : ℝ) (A : L2Z →L[ℂ] L2Z), IsSelfAdjoint A →
      IsSelfAdjoint (((r : ℝ) : ℂ) • A) := by
    intro r A hA
    change star _ = _
    rw [star_smul, hA.star_eq]
    congr 1
    exact Complex.conj_ofReal r
  have hdrift : IsSelfAdjoint (∑ i : Fin 3, ((fr i : ℝ) : ℂ) • velocityOp (v i)) := by
    change star _ = _
    rw [star_sum]
    exact Finset.sum_congr rfl fun i _ =>
      (hreal (fr i) _ (velocityOp_isSelfAdjoint (v i))).star_eq
  exact (((hreal _ _ hsum).add (hreal _ _ hsum)).add hdrift).add (velocityOp_isSelfAdjoint w)
