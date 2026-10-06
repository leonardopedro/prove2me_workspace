-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.weyl_complete_reducibility
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_codim_one
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_isInv_scalarOps
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] (R : Sl2Rep V) (W : Submodule ℂ V)
    (hW : R.IsInv W) : ∃ W' : Submodule ℂ V, R.IsInv W' ∧ IsCompl W W' := by

  classical
  by_cases hWbot : W = ⊥
  · refine ⟨⊤, ⟨fun _ _ => trivial, fun _ _ => trivial, fun _ _ => trivial⟩, ?_⟩
    rw [hWbot]
    exact isCompl_bot_top
  obtain ⟨w0, hw0W, hw0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hWbot
  obtain ⟨psi, hpsi⟩ := Module.Projective.exists_dual_eq_one ℂ hw0
  -- a vector-space projection onto `W`
  obtain ⟨C, hC⟩ := Submodule.exists_isCompl W
  set p : Module.End ℂ V := W.subtype ∘ₗ W.projectionOnto C hC with hp
  have hpW : ∀ v : V, p v ∈ W := fun v => (W.projectionOnto C hC v).2
  have hpid : ∀ w ∈ W, p w = w := by
    intro w hw
    have h : W.projectionOnto C hC w = ⟨w, hw⟩ :=
      Submodule.projectionOnto_apply_of_mem_left hC hw
    simp only [hp, LinearMap.comp_apply]
    rw [h]
    rfl
  have hpmem : p ∈ scalarOps W := ⟨hpW, 1, fun w hw => by rw [hpid w hw, one_smul]⟩
  -- the codimension-one situation inside `scalarOps W`
  set S := scalarOps W with hS
  have hSinv : (adRep R).IsInv S := isInv_scalarOps hW
  set RS := (adRep R).restr S hSinv with hRS
  set phi : ↥S →ₗ[ℂ] ℂ :=
    { toFun := fun f => psi ((f : Module.End ℂ V) w0)
      map_add' := by intro f g; simp
      map_smul' := by intro a f; simp } with hphi
  have hphi_apply : ∀ f : ↥S, phi f = psi ((f : Module.End ℂ V) w0) := fun _ => rfl
  have hscal : ∀ (f : ↥S) (w : V), w ∈ W → (f : Module.End ℂ V) w = phi f • w := by
    intro f w hw
    obtain ⟨-, c, hc⟩ := f.2
    have hc0 : phi f = c := by
      rw [hphi_apply, hc w0 hw0W, map_smul, hpsi, smul_eq_mul, mul_one]
    rw [hc0, hc w hw]
  have hv0 : phi ⟨p, hpmem⟩ = 1 := by
    rw [hphi_apply]
    exact (congrArg psi (hpid w0 hw0W)).trans hpsi
  have hann : ∀ (a : Module.End ℂ V), (∀ x ∈ W, a x ∈ W) → ∀ f : ↥S,
      psi ((a * (f : Module.End ℂ V) - (f : Module.End ℂ V) * a) w0) = 0 := by
    intro a ha f
    simp only [Module.End.mul_apply, LinearMap.sub_apply]
    rw [hscal f w0 hw0W, hscal f _ (ha w0 hw0W), map_smul, sub_self, map_zero]
  have hE : ∀ f : ↥S, phi (RS.E f) = 0 := fun f => hann R.E hW.1 f
  have hF : ∀ f : ↥S, phi (RS.F f) = 0 := fun f => hann R.F hW.2.1 f
  have hH : ∀ f : ↥S, phi (RS.H f) = 0 := fun f => hann R.H hW.2.2 f
  obtain ⟨x, hx1, hxE, hxF, hxH⟩ :=
    codim_one (Module.finrank ℂ (LinearMap.ker phi)) RS phi ⟨p, hpmem⟩ hv0 hE hF hH le_rfl
  set f : Module.End ℂ V := (x : Module.End ℂ V) with hf
  have hfW : ∀ v : V, f v ∈ W := x.2.1
  have hfid : ∀ w ∈ W, f w = w := by
    intro w hw
    rw [hf, hscal x w hw, hx1, one_smul]
  have hfE : ∀ v : V, f (R.E v) = R.E (f v) := by
    have h0 : R.E * f - f * R.E = 0 := by
      have := congrArg (fun y : ↥S => (y : Module.End ℂ V)) hxE
      simpa [hRS, hf] using this
    intro v
    have h1 := congrArg (fun T : Module.End ℂ V => T v) h0
    simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply] at h1
    exact (sub_eq_zero.mp h1).symm
  have hfF : ∀ v : V, f (R.F v) = R.F (f v) := by
    have h0 : R.F * f - f * R.F = 0 := by
      have := congrArg (fun y : ↥S => (y : Module.End ℂ V)) hxF
      simpa [hRS, hf] using this
    intro v
    have h1 := congrArg (fun T : Module.End ℂ V => T v) h0
    simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply] at h1
    exact (sub_eq_zero.mp h1).symm
  have hfH : ∀ v : V, f (R.H v) = R.H (f v) := by
    have h0 : R.H * f - f * R.H = 0 := by
      have := congrArg (fun y : ↥S => (y : Module.End ℂ V)) hxH
      simpa [hRS, hf] using this
    intro v
    have h1 := congrArg (fun T : Module.End ℂ V => T v) h0
    simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply] at h1
    exact (sub_eq_zero.mp h1).symm
  -- `f` is an equivariant projection onto `W`, so its kernel is an invariant complement
  refine ⟨LinearMap.ker f, ⟨fun v hv => ?_, fun v hv => ?_, fun v hv => ?_⟩, ⟨?_, ?_⟩⟩
  · rw [LinearMap.mem_ker] at hv ⊢
    rw [hfE, hv, map_zero]
  · rw [LinearMap.mem_ker] at hv ⊢
    rw [hfF, hv, map_zero]
  · rw [LinearMap.mem_ker] at hv ⊢
    rw [hfH, hv, map_zero]
  · refine Submodule.disjoint_def.mpr fun y hyW hyker => ?_
    rw [LinearMap.mem_ker] at hyker
    rw [← hfid y hyW, hyker]
  · refine codisjoint_iff.mpr (eq_top_iff.mpr fun v _ => ?_)
    refine Submodule.mem_sup.mpr ⟨f v, hfW v, v - f v, ?_, by abel⟩
    rw [LinearMap.mem_ker, map_sub, hfid (f v) (hfW v), sub_self]
