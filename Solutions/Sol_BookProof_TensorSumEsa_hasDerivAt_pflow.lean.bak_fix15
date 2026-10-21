-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.hasDerivAt_pflow
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_mem_span_tmul
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
    @HasDerivAt ℝ _ (Hs.carrier ⊗[ℂ] Ks.carrier)
      TensorProduct.instNormedAddCommGroup.toAddCommGroup (NormedSpace.complexToReal.toModule)
      _ _ (fun s : ℝ => inclPair Hs Ks DA DB (pflow P Q s x))
      ((-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t x)) t := by

  have hpure : ∀ (a : DA) (b : DB),
      HasDerivAt (fun s : ℝ => inclPair Hs Ks DA DB (pflow P Q s (a ⊗ₜ[ℂ] b)))
        ((-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t (a ⊗ₜ[ℂ] b))) t := by
    intro a b
    have hf : HasDerivAt (fun s : ℝ => P.U s (a : Hs.carrier))
        ((-Complex.I) • A ⟨P.U t (a : Hs.carrier), P.mem_domain t a⟩) t := P.hasDerivAt_U a t
    have hg : HasDerivAt (fun s : ℝ => Q.U s (b : Ks.carrier))
        ((-Complex.I) • B ⟨Q.U t (b : Ks.carrier), Q.mem_domain t b⟩) t := Q.hasDerivAt_U b t
    have h := hasDerivAt_tmul hf hg
    have hcurve : (fun s : ℝ => (P.U s (a : Hs.carrier)) ⊗ₜ[ℂ] (Q.U s (b : Ks.carrier)))
        = fun s : ℝ => inclPair Hs Ks DA DB (pflow P Q s (a ⊗ₜ[ℂ] b)) := by
      funext s
      rw [pflow_tmul, inclPair_tmul, OneParticleFlow.dmap_coe, OneParticleFlow.dmap_coe]
    rw [hcurve] at h
    have hval : ((-Complex.I) • A ⟨P.U t (a : Hs.carrier), P.mem_domain t a⟩)
          ⊗ₜ[ℂ] (Q.U t (b : Ks.carrier))
        + (P.U t (a : Hs.carrier)) ⊗ₜ[ℂ]
            ((-Complex.I) • B ⟨Q.U t (b : Ks.carrier), Q.mem_domain t b⟩)
        = (-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t (a ⊗ₜ[ℂ] b)) := by
      rw [pflow_tmul, sumPoly_tmul, ← TensorProduct.smul_tmul', TensorProduct.tmul_smul,
        ← smul_add, OneParticleFlow.dmap_coe, OneParticleFlow.dmap_coe]
      rfl
    rw [hval] at h
    exact h
  induction (mem_span_tmul x) using Submodule.span_induction with
  | mem y hy => obtain ⟨p, q, rfl⟩ := hy; exact hpure p q
  | zero =>
      have h : HasDerivAt (fun _ : ℝ => (0 : Hs.carrier ⊗[ℂ] Ks.carrier)) 0 t :=
        hasDerivAt_const _ _
      simpa using h
  | add a b _ _ ha hb =>
      have h := ha.add hb
      convert h using 1
      · funext s; simp [pflow, map_add]
      · simp [pflow, map_add, smul_add]
  | smul c a _ ha =>
      have h := ha.const_smul c
      have hfun : (c • fun s : ℝ => inclPair Hs Ks DA DB (pflow P Q s a))
          = fun s : ℝ => inclPair Hs Ks DA DB (pflow P Q s (c • a)) := by
        funext s; simp
      rw [hfun] at h
      have hval : c • ((-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t a))
          = (-Complex.I) • sumPoly Hs Ks DA DB A B (pflow P Q t (c • a)) := by
        rw [map_smul, map_smul]
        exact smul_comm c (-Complex.I) _
      rw [hval] at h
      exact h
