-- Generated from ChapterStoneConverse.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.gen_stoneU_apply_eq_domain
import Mathlib
import Definitions.Def_ChapterStoneConverse
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_eq_of_inner_eq_on_dense
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_inner_stoneU_map_map
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_op
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
] H).inner_map_map a b

theorem solution (t : ℝ) (x : G.genDomain) :
    G.gen.stoneU t :=
  (x : H) = G.U t (x : H) := by
    refine eq_of_inner_eq_on_dense G.denseDomain ?_
    rintro z hz
    set Z : G.genDomain := ⟨z, hz⟩ with hZ
    set g : ℝ → ℂ := fun s => ⟪G.gen.stoneU (s - t) z, G.U s (x : H)⟫_ℂ with hgdef
    have hd : ∀ s : ℝ, HasDerivAt g 0 s := by
      intro s
      have ha : HasDerivAt (fun u : ℝ => G.gen.stoneU (u - t) z)
          (G.gen.stoneU (s - t) ((-Complex.I) • G.genOp Z)) s :=
        HasDerivAt.comp_sub_const s t (G.gen.hasDerivAt_stoneU Z (s - t))
      have hb : HasDerivAt (fun u : ℝ => G.U u (x : H))
          ((-Complex.I) • G.U s (G.genOp x)) s := G.hasDerivAt_orbit x s
      have hsum := HasDerivAt.inner ℂ ha hb
      have hmemV : G.gen.stoneU (s - t) z ∈ G.genDomain := G.gen.stoneU_mem_domain (s - t) Z
      have hmemU : G.U s (x : H) ∈ G.genDomain := G.apply_mem_genDomain s x
      have hop : G.genOp ⟨G.gen.stoneU (s - t) z, hmemV⟩
          = G.gen.stoneU (s - t) (G.genOp Z) := G.gen.stoneU_op (s - t) Z
      have hsym := G.symmetric ⟨G.gen.stoneU (s - t) z, hmemV⟩ ⟨G.U s (x : H), hmemU⟩
      have hUcomm : G.genOp ⟨G.U s (x : H), hmemU⟩ = G.U s (G.genOp x) :=
        G.genOp_apply_comm s x
      have hzero : ⟪G.gen.stoneU (s - t) z, (-Complex.I) • G.U s (G.genOp x)⟫_ℂ
          + ⟪G.gen.stoneU (s - t) ((-Complex.I) • G.genOp Z), G.U s (x : H)⟫_ℂ = 0 := by
        rw [inner_smul_right, map_smul, inner_smul_left, ← hop, hsym, hUcomm]
        simp only [map_neg, Complex.conj_I, neg_neg]
        ring
      rw [hzero] at hsum
      exact hsum
    have hconst : g 0 = g t :=
      is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt) (fun s => (hd s).deriv) 0 t
    have h0 : g 0 = ⟪G.gen.stoneU (-t) z, (x : H)⟫_ℂ := by
      rw [hgdef]
      simp
    have ht : g t = ⟪z, G.U t (x : H)⟫_ℂ := by
      rw [hgdef]
      simp
    have hshift : ⟪G.gen.stoneU (-t) z, (x : H)⟫_ℂ = ⟪z, G.gen.stoneU t (x : H)⟫_ℂ := by
      have h := inner_stoneU_map_map G.gen t (G.gen.stoneU (-t) z) (x : H)
      rw [G.gen.stoneU_apply_stoneU] at h
      simp only [add_neg_cancel] at h
      rw [show G.gen.stoneU 0 z = z from by simp] at h
      exact h.symm
    exact hshift.symm.trans (h0.symm.
