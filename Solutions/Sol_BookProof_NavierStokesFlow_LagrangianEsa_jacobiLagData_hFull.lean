-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.jacobiLagData_hFull
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution : jacobiLagData.hFull = jacobiOp :=
  yOn _ _ _ _ _ _
  
  end Diagonal
  
  /-! ## Sharpness: the transformed shape alone does not give ESA -/
  
  section Sharpness
  
  open LpNat JacobiDeficiency FullEsa
  
  /-- Transformed Navier–Stokes data on `ℓ²(ℕ)` whose only nonzero term is the
  first-order **drift**, realized by the tridiagonal (limit-circle) operator of
  `BookProof.ChapterNavierStokesDeficiency`. -/
  noncomputable def jacobiLagData : LagrangianFullData L2N where
    D := lpFiniteModes ℕ
    P _ := 0
    Q _ := 0
    drive i := if i = 0 then jacobiOp else 0
    force i := if i = 0 then 1 else 0
    constraintOp := 0
    nu := 0
    dense := lpFiniteModes_dense
    P_symm _ := IsSymmetricDom.zero
    Q_symm _ := IsSymmetricDom.zero
    drive_symm i := by
      by_cases hi : i = 0
      · rw [hi, if_pos rfl]
        exact fun x y => jacobiOp_symmetric x y
      · rw [if_neg hi]
        exact IsSymmetricDom.zero
    constraint_symm := IsSymmetricDom.zero
    nu_nonneg := le_refl 0
  
  theorem jacobiLagData_hFull : jacobiLagData.hFull = jacobiOp := by
    have hP : ∀ i : Fin 3, jacobiLagData.P i = 0 := fun _ => rfl
    have hQ : ∀ i : Fin 3, jacobiLagData.Q i = 0 := fun _ => rfl
    have hC : jacobiLagData.constraintOp = 0 := rfl
    have hd0 : jacobiLagData.drive 0 = jacobiOp := by
      change (if (0 : Fin 3) = 0 then jacobiOp else 0) = jacobiOp
      rw [if_pos rfl]
    have hd1 : jacobiLagData.drive 1 =
