-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.friedrichs_canonical
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_exists_formExt_eq
import Theorems.Thm_BookProof_FriedrichsCanonical_resolvent_mem_friedrichsDomain
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichsOp_resolvent
import Theorems.Thm_BookProof_FriedrichsCanonical_eq_zero_of_inner_coe_eq_zero
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_apply
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_isSelfAdjoint
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_friedrichsResolvent_shift
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_inner_coe_eq
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hext : ∀ x : P.dom, ∃ h : (x : F) ∈ Dom', A' ⟨(x : F), h⟩ = P.op x)
    (hsym : SymmetricOn Dom' A') (hform : Dom' ≤ formDomain P)
    (x : F) (hx : x ∈ Dom') :
    ∃ h : x ∈ friedrichsDomain P, friedrichsOp P hdense ⟨x, h⟩ = A' ⟨x, hx⟩ := by

  obtain ⟨u, hu⟩ : ∃ u : F, u = A' ⟨x, hx⟩ + x := ⟨_, rfl⟩
  -- the difference `x − S u` lies in the form domain, so it is `formExt k`
  obtain ⟨k₁, hk₁⟩ := exists_formExt_eq (hform hx)
  have hkval : formExt P (k₁ - formRiesz P u) = x - friedrichsResolvent P u := by
    rw [map_sub, hk₁, friedrichsResolvent_apply]
  -- `k` is form-orthogonal to the domain
  have hzero : ∀ v : FormDom P,
      (inner ℂ (v : FormSpace P) (k₁ - formRiesz P u) : ℂ) = 0 := by
    intro v
    rw [inner_coe_eq, hkval, inner_sub_right]
    -- pairing with `x`
    have hxpair : (inner ℂ (toAmbient v + P.op (toDom v)) x : ℂ)
        = inner ℂ (toAmbient v) u := by
      obtain ⟨hmem, hval⟩ := hext (toDom v)
      have hsy : (inner ℂ (A' ⟨((toDom v : P.dom) : F), hmem⟩) x : ℂ)
          = inner ℂ ((toDom v : P.dom) : F) (A' ⟨x, hx⟩) := hsym ⟨_, hmem⟩ ⟨x, hx⟩
      rw [hval] at hsy
      rw [toAmbient_eq, inner_add_left, hsy, hu, inner_add_right]
      ring
    -- pairing with `S u`
    have hypair : (inner ℂ (toAmbient v + P.op (toDom v)) (friedrichsResolvent P u) : ℂ)
        = inner ℂ (toAmbient v) u := by
      have hsa := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp
        (friedrichsResolvent_isSelfAdjoint P)
      rw [toAmbient_eq]
      have h1 : (inner ℂ (((toDom v : P.dom) : F) + P.op (toDom v))
            (friedrichsResolvent P u) : ℂ)
          = inner ℂ (friedrichsResolvent P (((toDom v : P.dom) : F) + P.op (toDom v))) u :=
        (hsa (((toDom v : P.dom) : F) + P.op (toDom v)) u).symm
      rw [h1, friedrichsResolvent_shift P (toDom v)]
    rw [hxpair, hypair, sub_self]
  have hk0 : k₁ - formRiesz P u = 0 := eq_zero_of_inner_coe_eq_zero P _ hzero
  have hxy : x = friedrichsResolvent P u := by
    have h0 : x - friedrichsResolvent P u = 0 := by rw [← hkval, hk0, map_zero]
    exact sub_eq_zero.mp h0
  have hmem : x ∈ friedrichsDomain P := by
    rw [hxy]; exact resolvent_mem_friedrichsDomain P u
  refine ⟨hmem, ?_⟩
  have hcongr : (⟨x, hmem⟩ : friedrichsDomain P)
      = ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩ := Subtype.ext hxy
  rw [hcongr, friedrichsOp_resolvent, ← hxy, hu]
  module
