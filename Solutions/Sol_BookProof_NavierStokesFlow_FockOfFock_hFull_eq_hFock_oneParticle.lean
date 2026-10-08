-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.hFull_eq_hFock_oneParticle
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_basis
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_hFull_eigenvector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 ≤ nu) (p q dr : Fin 3 → M → ℝ)
    (force : Fin 3 → ℝ) (cst : M → ℝ) (m : M) :
    (lagrangianFockData nu hnu p q dr force cst).hFull (fockBasis (Finsupp.single m 1))
      = hFockLag nu p q dr force cst (fockBasis (Finsupp.single m 1)) := by

  classical
  have hsingle : ∀ ω : M → ℝ, confEnergy ω (Finsupp.single m 1 : Conf M) = ω m := by
    intro ω
    simp [confEnergy, Finsupp.support_single_ne_zero _ (one_ne_zero)]
  have heig := (lagrangianFockData nu hnu p q dr force cst).hFull_eigenvector
    (v := (fockBasis (Finsupp.single m 1) : FockDom M))
    (p := fun i => p i m) (q := fun i => q i m) (dr := fun i => dr i m) (c := cst m)
    (fun i => by
      simp only [lagrangianFockData]
      have hp := dGamma_basis (p i) (Finsupp.single m 1)
      rw [hsingle] at hp
      exact hp)
    (fun i => by
      simp only [lagrangianFockData]
      have hq := dGamma_basis (q i) (Finsupp.single m 1)
      rw [hsingle] at hq
      exact hq)
    (fun i => by
      simp only [lagrangianFockData]
      have hd := dGamma_basis (dr i) (Finsupp.single m 1)
      rw [hsingle] at hd
      exact hd)
    (by
      simp only [lagrangianFockData]
      have hc := dGamma_basis cst (Finsupp.single m 1)
      rw [hsingle] at hc
      exact hc)
  rw [heig, hFockLag, dGamma_basis, hsingle]
  rfl
