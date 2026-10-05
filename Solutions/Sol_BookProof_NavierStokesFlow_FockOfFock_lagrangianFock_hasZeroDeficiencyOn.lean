-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lagrangianFock_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_basis
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpBasis_total
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 ≤ nu) (p q dr : Fin 3 → M → ℝ)
    (force : Fin 3 → ℝ) (cst : M → ℝ) :
    HasZeroDeficiencyOn (lagrangianFockData nu hnu p q dr force cst).D
      (lagrangianFockData nu hnu p q dr force cst).hFull := by

  classical
  exact (lagrangianFockData nu hnu p q dr force cst).hasZeroDeficiencyOn_of_commonEigenvectors
    (fun n : Conf M => (fockBasis n : FockDom M))
    (fun i n => confEnergy (p i) n) (fun i n => confEnergy (q i) n)
    (fun i n => confEnergy (dr i) n) (fun n => confEnergy cst n)
    (fun i n => dGamma_basis (p i) n) (fun i n => dGamma_basis (q i) n)
    (fun i n => dGamma_basis (dr i) n) (fun n => dGamma_basis cst n)
    lpBasis_total
