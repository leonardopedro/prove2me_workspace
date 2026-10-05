import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterVonNeumannCore
import Mathlib


/-!
# `|Ā| = (A* Ā)^{1/2}` is *the* non-negative square root — uniqueness

`BookProof.ChapterUnboundedPolar` constructs `absRel A = |Ā|`, proves it
self-adjoint and non-negative, and proves `|Ā|² = A* Ā` (`absRel_comp_self`).
What was missing — the reason `(A* Ā)^{1/2}` could only be called *a* square root
— is **uniqueness**: that no other non-negative self-adjoint relation squares to
`A* Ā`.  Classically this is read off the spectral theorem for unbounded
self-adjoint operators.  This module proves it with the **bounded** continuous
functional calculus only.

## The argument

Let `T` be a non-negative self-adjoint linear relation (`IsNonnegSelfAdjoint`).

* Part 1.  `1 + T` is injective with closed dense range, hence bijective, so it
  has an everywhere-defined inverse `invCLM T`, a positive contraction; and `T`
  is recovered from it, `T = {(C h, h − C h)}` (`rel_eq_of_invCLM_eq`).
* Part 2.  If moreover `T T ⊆ A* Ā`, then with `C = invCLM T` and
  `R = (1 + A* Ā)⁻¹` one has the **bounded** identity
  `R (1 − 2C + 2C²) = C²` (`resCLM_mul_den`): indeed for `x = C h` and
  `u = C x`, the pair `(u, h − 2x + u)` lies in `T T ⊆ A* Ā` and its coordinates
  add up to `h − 2x + 2u`.
* Part 3.  On the spectrum of `C`, which lies in `[0, 1]`, the identity says
  `R = g(C)` with `g t = t²/(2t² − 2t + 1)`, and `g` is inverted on `[0,1]` by the
  continuous `ψ r = √r/(√r + √(1−r))`.  Hence **`C = ψ(R)`** (`invCLM_eq_cfc`) —
  the inverse of `1 + T` is determined by `A` alone.
* Part 4.  Therefore any two such `T` agree; since `absRel A` is one of them,
  **`T = |Ā|`** (`eq_absRel_of_isNonnegSelfAdjoint`), and `|Ā|` is the unique
  non-negative self-adjoint square root of `A* Ā`
  (`absRel_unique_nonneg_sqrt`).

Only `A : D →ₗ[ℂ] F` on a complex Hilbert space is needed; neither density of `D`
nor symmetry of `A` enters the uniqueness statement.
-/

namespace BookProof.PositiveSquareRoot

open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## Part 1 — a non-negative self-adjoint relation and its bounded inverse -/

/-- A linear relation which is self-adjoint and non-negative. -/
structure IsNonnegSelfAdjoint (T : Submodule ℂ (F × F)) : Prop where
  /-- `T* = T`. -/
  adj : adjPairs T = T
  /-- `⟪x, T x⟫ ≥ 0`. -/
  nonneg : ∀ p ∈ T, 0 ≤ (inner ℂ p.1 p.2 : ℂ).re

variable {T T₁ T₂ : Submodule ℂ (F × F)}



/-- `‖x‖² + ‖T x‖² ≤ ‖x + T x‖²`. -/
theorem norm_sq_add_le (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ T) :
    ‖p.1‖ ^ 2 + ‖p.2‖ ^ 2 ≤ ‖p.1 + p.2‖ ^ 2 := by
  have hre := hT.nonneg p hp
  have h := norm_add_sq (𝕜 := ℂ) p.1 p.2
  simp only [RCLike.re_to_complex] at h hre
  linarith

theorem norm_fst_le (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ T) :
    ‖p.1‖ ≤ ‖p.1 + p.2‖ := by
  have h := norm_sq_add_le hT hp
  nlinarith [norm_nonneg p.1, norm_nonneg p.2, norm_nonneg (p.1 + p.2)]

theorem norm_snd_le (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ T) :
    ‖p.2‖ ≤ ‖p.1 + p.2‖ := by
  have h := norm_sq_add_le hT hp
  nlinarith [norm_nonneg p.1, norm_nonneg p.2, norm_nonneg (p.1 + p.2)]

/-- `1 + T` is injective. -/
theorem eq_of_add_eq (hT : IsNonnegSelfAdjoint T) {p q : F × F} (hp : p ∈ T) (hq : q ∈ T)
    (hsum : p.1 + p.2 = q.1 + q.2) : p = q := by
  have hd : p - q ∈ T := T.sub_mem hp hq
  have h0 : (p - q).1 + (p - q).2 = 0 := by
    simp only [Prod.fst_sub, Prod.snd_sub]
    rw [show p.1 - q.1 + (p.2 - q.2) = (p.1 + p.2) - (q.1 + q.2) by abel, hsum, sub_self]
  have h1 : ‖(p - q).1‖ ≤ 0 := by
    have := norm_fst_le hT hd; rwa [h0, norm_zero] at this
  have h2 : ‖(p - q).2‖ ≤ 0 := by
    have := norm_snd_le hT hd; rwa [h0, norm_zero] at this
  have hz : p - q = 0 := by
    refine Prod.ext ?_ ?_
    · simpa using norm_le_zero_iff.1 h1
    · simpa using norm_le_zero_iff.1 h2
  exact sub_eq_zero.1 hz

theorem isClosed_rel (hT : IsNonnegSelfAdjoint T) :
    IsClosed ((T : Submodule ℂ (F × F)) : Set (F × F)) := by
  rw [← hT.adj]
  exact adjPairs_isClosed T

/-- The map `(x, w) ↦ x + w`. -/
def sumMap : (F × F) →ₗ[ℂ] F := LinearMap.fst ℂ F F + LinearMap.snd ℂ F F

@[simp] theorem sumMap_apply (p : F × F) : sumMap p = p.1 + p.2 := rfl

section Complete

variable [CompleteSpace F]

/-- The range of `1 + T` is closed. -/
theorem isClosed_rangeSum (hT : IsNonnegSelfAdjoint T) :
    IsClosed (((T.map sumMap : Submodule ℂ F)) : Set F) := by
  refine IsSeqClosed.isClosed ?_
  intro u h hu hlim
  choose p hp hpu using fun n => Submodule.mem_map.1 (hu n)
  have hnorm : ∀ n m : ℕ,
      ‖(p n).1 - (p m).1‖ ≤ ‖u n - u m‖ ∧ ‖(p n).2 - (p m).2‖ ≤ ‖u n - u m‖ := by
    intro n m
    have hd : p n - p m ∈ T := T.sub_mem (hp n) (hp m)
    have e1 : (p n).1 + (p n).2 = u n := hpu n
    have e2 : (p m).1 + (p m).2 = u m := hpu m
    have hsum : (p n - p m).1 + (p n - p m).2 = u n - u m := by
      simp only [Prod.fst_sub, Prod.snd_sub]
      rw [show (p n).1 - (p m).1 + ((p n).2 - (p m).2)
          = ((p n).1 + (p n).2) - ((p m).1 + (p m).2) by abel, e1, e2]
    refine ⟨?_, ?_⟩
    · have := norm_fst_le hT hd; rwa [hsum] at this
    · have := norm_snd_le hT hd; rwa [hsum] at this
  have hcu : CauchySeq u := hlim.cauchySeq
  rw [Metric.cauchySeq_iff] at hcu
  have hc1 : CauchySeq fun n => (p n).1 := by
    rw [Metric.cauchySeq_iff]
    intro ε hε
    obtain ⟨N, hN⟩ := hcu ε hε
    refine ⟨N, fun n hn m hm => ?_⟩
    have h1 := (hnorm n m).1
    have h2 := hN n hn m hm
    rw [dist_eq_norm] at h2 ⊢
    linarith
  have hc2 : CauchySeq fun n => (p n).2 := by
    rw [Metric.cauchySeq_iff]
    intro ε hε
    obtain ⟨N, hN⟩ := hcu ε hε
    refine ⟨N, fun n hn m hm => ?_⟩
    have h1 := (hnorm n m).2
    have h2 := hN n hn m hm
    rw [dist_eq_norm] at h2 ⊢
    linarith
  obtain ⟨x, hx⟩ := cauchySeq_tendsto_of_complete hc1
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hc2
  have hmem : (x, w) ∈ T := by
    have hlim2 : Filter.Tendsto p Filter.atTop (nhds (x, w)) := hx.prodMk_nhds hw
    exact (isClosed_rel hT).mem_of_tendsto hlim2 (Filter.Eventually.of_forall hp)
  have hsum : x + w = h := by
    have h1 : Filter.Tendsto (fun n => (p n).1 + (p n).2) Filter.atTop (nhds (x + w)) := hx.add hw
    have h2 : Filter.Tendsto (fun n => (p n).1 + (p n).2) Filter.atTop (nhds h) := by
      have : (fun n => (p n).1 + (p n).2) = u := funext hpu
      rw [this]; exact hlim
    exact tendsto_nhds_unique h1 h2
  exact Submodule.mem_map.2 ⟨(x, w), hmem, hsum⟩

omit [CompleteSpace F] in
/-- The orthogonal complement of the range of `1 + T` is trivial. -/
theorem rangeSum_orthogonal_eq_bot (hT : IsNonnegSelfAdjoint T) :
    ((T.map sumMap : Submodule ℂ F))ᗮ = ⊥ := by
  rw [Submodule.eq_bot_iff]
  intro v hv
  have hadj : (v, -v) ∈ adjPairs T := by
    intro q hq
    have h0 : (inner ℂ (q.1 + q.2) v : ℂ) = 0 :=
      hv _ (Submodule.mem_map.2 ⟨q, hq, rfl⟩)
    rw [inner_add_left] at h0
    simp only [inner_neg_right]
    linear_combination h0
  have hmemT : (v, -v) ∈ T := by rw [← hT.adj]; exact hadj
  have hre := hT.nonneg _ hmemT
  simp only [inner_neg_right, Complex.neg_re] at hre
  have hnn : (inner ℂ v v : ℂ).re = ‖v‖ ^ 2 := by
    rw [inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  rw [hnn] at hre
  have : ‖v‖ = 0 := by nlinarith [norm_nonneg v]
  simpa using this

/-- **`1 + T` is surjective.** -/
theorem exists_add_eq (hT : IsNonnegSelfAdjoint T) (h : F) :
    ∃ p : F × F, p ∈ T ∧ p.1 + p.2 = h := by
  haveI : CompleteSpace ((T.map sumMap : Submodule ℂ F)) :=
    (isClosed_rangeSum hT).completeSpace_coe
  have htop : (T.map sumMap : Submodule ℂ F) = ⊤ :=
    Submodule.orthogonal_eq_bot_iff.1 (rangeSum_orthogonal_eq_bot hT)
  have hmem : h ∈ (T.map sumMap : Submodule ℂ F) := by rw [htop]; trivial
  obtain ⟨p, hp, hps⟩ := Submodule.mem_map.1 hmem
  exact ⟨p, hp, hps⟩



/-- The unique solution pair of `x + T x = h`. -/
noncomputable def invPair (hT : IsNonnegSelfAdjoint T) (h : F) : F × F :=
  Classical.choose (exists_add_eq hT h)

theorem invPair_mem (hT : IsNonnegSelfAdjoint T) (h : F) : invPair hT h ∈ T :=
  (Classical.choose_spec (exists_add_eq hT h)).1

theorem invPair_add (hT : IsNonnegSelfAdjoint T) (h : F) :
    (invPair hT h).1 + (invPair hT h).2 = h :=
  (Classical.choose_spec (exists_add_eq hT h)).2

theorem invPair_unique (hT : IsNonnegSelfAdjoint T) {h : F} {p : F × F} (hp : p ∈ T)
    (hsum : p.1 + p.2 = h) : invPair hT h = p :=
  eq_of_add_eq hT (invPair_mem hT h) hp (by rw [invPair_add, hsum])

/-- `(1 + T)⁻¹` as a linear map. -/
noncomputable def invLin (hT : IsNonnegSelfAdjoint T) : F →ₗ[ℂ] F where
  toFun h := (invPair hT h).1
  map_add' h k := by
    have hpair : invPair hT (h + k) = invPair hT h + invPair hT k := by
      refine invPair_unique hT (T.add_mem (invPair_mem hT h) (invPair_mem hT k)) ?_
      simp only [Prod.fst_add, Prod.snd_add]
      rw [show (invPair hT h).1 + (invPair hT k).1 + ((invPair hT h).2 + (invPair hT k).2)
          = ((invPair hT h).1 + (invPair hT h).2) + ((invPair hT k).1 + (invPair hT k).2) by abel,
        invPair_add, invPair_add]
    rw [hpair]; rfl
  map_smul' c h := by
    have hpair : invPair hT (c • h) = c • invPair hT h := by
      refine invPair_unique hT (T.smul_mem c (invPair_mem hT h)) ?_
      simp only [Prod.smul_fst, Prod.smul_snd, ← smul_add]
      rw [invPair_add]
    rw [hpair]; rfl





theorem norm_invLin_le (hT : IsNonnegSelfAdjoint T) (h : F) : ‖invLin hT h‖ ≤ ‖h‖ := by
  have := norm_fst_le hT (invPair_mem hT h)
  rwa [invPair_add] at this

/-- **`(1 + T)⁻¹`, a positive contraction.** -/
noncomputable def invCLM (hT : IsNonnegSelfAdjoint T) : F →L[ℂ] F :=
  (invLin hT).mkContinuous 1 (fun h => by simpa using norm_invLin_le hT h)

@[simp] theorem invCLM_apply (hT : IsNonnegSelfAdjoint T) (h : F) : invCLM hT h = invLin hT h := rfl















/-! ## Part 2 — the bounded identity forced by `T T ⊆ A* Ā` -/

variable {D : Submodule ℂ F}



/-! ## Part 3 — the functional calculus: `C = ψ(R)` -/

/-- `g t = t² / (2t² − 2t + 1)`, written without division by a possibly vanishing
denominator: `2t² − 2t + 1 = t² + (1 − t)² > 0`. -/
noncomputable def gFun : ℝ → ℝ := fun t => t * t / (1 - t - t + t * t + t * t)

/-- `ψ r = √r / (√r + √(1 − r))`, the inverse of `g` on `[0, 1]`. -/
noncomputable def psiFun : ℝ → ℝ := fun r => Real.sqrt r / (Real.sqrt r + Real.sqrt (1 - r))













section Cfc

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]











end Cfc

/-! ## Part 4 — uniqueness of the non-negative square root -/









end Complete

end BookProof.PositiveSquareRoot
