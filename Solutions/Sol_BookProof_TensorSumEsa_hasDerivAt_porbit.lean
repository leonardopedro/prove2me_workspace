-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.hasDerivAt_porbit
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_cpairOp_apply
import Theorems.Thm_BookProof_TensorSumEsa_hasDerivAt_pflow
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)

set_option maxHeartbeats 1000000 in
theorem solution (x : DA ⊗[ℂ] DB) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ((porbit P Q x s : cpairDom Hs Ks DA DB) : ctensor Hs Ks))
      ((-Complex.I) • cpairOp Hs Ks DA DB A B (porbit P Q x t)) t := by

  have h := hasDerivAt_pflow P Q x t
  have hcomp := (((pairEmb Hs Ks).toContinuousLinearMap.restrictScalars
    ℝ).hasFDerivAt).comp_hasDerivAt t h
  have hop : cpairOp Hs Ks DA DB A B (porbit P Q x t)
      = pairEmb Hs Ks (sumPoly Hs Ks DA DB A B (pflow P Q t x)) :=
    cpairOp_apply Hs Ks DA DB A B (porbit P Q x t) (pflow P Q t x) rfl
  rw [hop]
  have hval : (ContinuousLinearMap.restrictScalars ℝ (pairEmb Hs Ks).toContinuousLinearMap)
      ((-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t x))
      = (-Complex.I) • pairEmb Hs Ks (sumPoly Hs Ks DA DB A B (pflow P Q t x)) := by
    simp
  rw [hval] at hcomp
  exact hcomp
