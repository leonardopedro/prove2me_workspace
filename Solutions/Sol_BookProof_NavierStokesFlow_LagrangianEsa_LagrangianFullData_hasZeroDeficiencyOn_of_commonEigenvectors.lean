-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_hasZeroDeficiencyOn_of_total_eigenvectors
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_hFull_eigenvector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution {I : Type*} (e : I → L.D)
    (p q dr : Fin 3 → I → ℝ) (c : I → ℝ)
    (hP : ∀ i a, L.P i (e a) = ((p i a : ℝ) : ℂ) • e a)
    (hQ : ∀ i a, L.Q i (e a) = ((q i a : ℝ) : ℂ) • e a)
    (hD : ∀ i a, L.drive i (e a) = ((dr i a : ℝ) : ℂ) • e a)
    (hC : ∀ a, L.constraintOp (e a) = ((c a : ℝ) : ℂ) • e a)
    (htotal : ∀ w : F, (∀ a, (inner ℂ ((e a : F)) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn L.D L.hFull :=
  L.hasZeroDeficiencyOn_of_total_eigenvectors e
      (fun a => L.eigenvalue (fun i => p i a) (fun i => q i a) (fun i => dr i a) (c a))
      (fun a => L.hFull_eigenvector (fun i => hP i a) (fun i => hQ i a) (fun i => hD i a) (hC a))
      htotal
