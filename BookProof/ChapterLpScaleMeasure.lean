import Mathlib
import BookProof.ChapterLinftyMultiplication

/-!
# Rescaling the measure does not change the multiplication algebra (plan GAP-2)

The diffuse model of the classification list (`ChapterDiffuseUnitaryModel`) is stated
for a *probability* measure, while the diffuse part produced by the atomic/diffuse
split of a summand (`ChapterMeasureAtomicDiffuse`) is only a finite measure of some
mass `m ∈ (0, 1)`.  The bridge between the two is the observation that multiplying a
measure by a nonzero finite constant changes the `L²` norm by a constant factor and
nothing else, so the two `L²` spaces are unitarily equivalent by a scalar multiple of
the identity — and the unitary evidently intertwines the multiplication operators.

* `ae_smul_measure_eq`, `memLp_two_smul_measure_iff`, `memLp_top_smul_measure_iff` —
  scaling the measure changes neither the null sets nor membership in `L²` or `L∞`;
* `transferLp` — the same a.e. class, read in the scaled measure;
* `scaleUnitary` — the unitary `L²(c·ν) ≃ₗᵢ[ℂ] L²(ν)`;
* `scaleUnitary_intertwines` — it carries multiplication by `g` to multiplication
  by `g`;
* `isProbabilityMeasure_inv_smul`, `normalized_multiplication_model` — **HEADLINE**:
  for a finite nonzero measure `ν` the multiplication algebra on `L²(ν)` is unitarily
  the multiplication algebra of the *probability* measure `ν / ν(univ)`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ENNReal

namespace BookProof.ChapterLpScaleMeasure

open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

/-! ## 1. Scaling changes neither the null sets nor the `L^p` classes -/

theorem ae_smul_measure_eq (hc : c ≠ 0) : ae (c • nu) = ae nu := by
  ext s
  simp only [mem_ae_iff, Measure.smul_apply, smul_eq_mul, mul_eq_zero, hc, false_or]

theorem aestronglyMeasurable_smul_measure_iff (hc : c ≠ 0) {f : α → ℂ} :
    AEStronglyMeasurable f (c • nu) ↔ AEStronglyMeasurable f nu := by
  constructor
  · rintro ⟨g, hg, hfg⟩
    exact ⟨g, hg, by rwa [ae_smul_measure_eq hc] at hfg⟩
  · rintro ⟨g, hg, hfg⟩
    exact ⟨g, hg, by rwa [ae_smul_measure_eq hc]⟩

theorem eLpNorm_two_smul_measure (hc : c ≠ 0) (f : α → ℂ) :
    eLpNorm f 2 (c • nu) = c ^ (1 / 2 : ℝ) * eLpNorm f 2 nu := by
  rw [eLpNorm_smul_measure_of_ne_zero hc]
  norm_num

theorem rpow_half_ne_zero (hc0 : c ≠ 0) (hctop : c ≠ ⊤) : c ^ (1 / 2 : ℝ) ≠ 0 := by
  simp [ENNReal.rpow_eq_zero_iff, hc0, hctop]

theorem rpow_half_ne_top (hc0 : c ≠ 0) (hctop : c ≠ ⊤) : c ^ (1 / 2 : ℝ) ≠ ⊤ := by
  simp [ENNReal.rpow_eq_top_iff, hc0, hctop]

theorem memLp_two_smul_measure_iff (hc0 : c ≠ 0) (hctop : c ≠ ⊤) {f : α → ℂ} :
    MemLp f 2 (c • nu) ↔ MemLp f 2 nu := by
  constructor
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).1 hm, ?_⟩
    rw [eLpNorm_two_smul_measure hc0] at hlt
    by_contra hcon
    rw [not_lt, top_le_iff] at hcon
    rw [hcon, ENNReal.mul_top (rpow_half_ne_zero hc0 hctop)] at hlt
    exact lt_irrefl _ hlt
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).2 hm, ?_⟩
    rw [eLpNorm_two_smul_measure hc0]
    exact ENNReal.mul_lt_top (lt_top_iff_ne_top.2 (rpow_half_ne_top hc0 hctop)) hlt

theorem memLp_top_smul_measure_iff (hc0 : c ≠ 0) {f : α → ℂ} :
    MemLp f ⊤ (c • nu) ↔ MemLp f ⊤ nu := by
  constructor
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).1 hm, ?_⟩
    rwa [eLpNorm_exponent_top, eLpNormEssSup_ennreal_smul_measure hc0] at hlt
  · rintro ⟨hm, hlt⟩
    refine ⟨(aestronglyMeasurable_smul_measure_iff hc0).2 hm, ?_⟩
    rwa [eLpNorm_exponent_top, eLpNormEssSup_ennreal_smul_measure hc0]

/-! ## 2. Reading the same a.e. class in the unscaled measure -/

/-- The same a.e. class, read as an element of `L²(ν)`. -/
def transferLp (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) : Lp ℂ 2 nu :=
  ((memLp_two_smul_measure_iff hc0 hctop).1 (Lp.memLp u)).toLp _

theorem transferLp_coeFn (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    (transferLp hc0 hctop u : α → ℂ) =ᵐ[nu] (u : α → ℂ) :=
  MemLp.coeFn_toLp _

theorem transferLp_add (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u v : Lp ℂ 2 (c • nu)) :
    transferLp hc0 hctop (u + v) = transferLp hc0 hctop u + transferLp hc0 hctop v := by
  refine Lp.ext ?_
  have hae : (↑↑(u + v) : α → ℂ) =ᵐ[nu] (↑↑u : α → ℂ) + ↑↑v := by
    have h := Lp.coeFn_add u v
    rwa [Filter.EventuallyEq, ae_smul_measure_eq hc0] at h
  filter_upwards [transferLp_coeFn hc0 hctop (u + v),
    Lp.coeFn_add (transferLp hc0 hctop u) (transferLp hc0 hctop v),
    transferLp_coeFn hc0 hctop u, transferLp_coeFn hc0 hctop v, hae] with x h1 h2 h3 h4 h5
  rw [h1, h2]
  simp only [Pi.add_apply]
  rw [h3, h4, h5]
  simp

theorem transferLp_smul (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (a : ℂ) (u : Lp ℂ 2 (c • nu)) :
    transferLp hc0 hctop (a • u) = a • transferLp hc0 hctop u := by
  refine Lp.ext ?_
  have hae : (↑↑(a • u) : α → ℂ) =ᵐ[nu] a • (↑↑u : α → ℂ) := by
    have h := Lp.coeFn_smul a u
    rwa [Filter.EventuallyEq, ae_smul_measure_eq hc0] at h
  filter_upwards [transferLp_coeFn hc0 hctop (a • u),
    Lp.coeFn_smul a (transferLp hc0 hctop u),
    transferLp_coeFn hc0 hctop u, hae] with x h1 h2 h3 h4
  rw [h1, h2]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [h3, h4]
  simp

/-! ## 3. The unitary -/

/-- The scalar by which the `L²` norm changes when the measure is scaled by `c`. -/
def scaleConst (c : ENNReal) : ℝ := (c ^ (1 / 2 : ℝ)).toReal

theorem scaleConst_pos (hc0 : c ≠ 0) (hctop : c ≠ ⊤) : 0 < scaleConst c :=
  ENNReal.toReal_pos (rpow_half_ne_zero hc0 hctop) (rpow_half_ne_top hc0 hctop)

/-- The underlying linear map of the scaling unitary. -/
def scaleLin (hc0 : c ≠ 0) (hctop : c ≠ ⊤) : Lp ℂ 2 (c • nu) →ₗ[ℂ] Lp ℂ 2 nu where
  toFun u := (scaleConst c : ℂ) • transferLp hc0 hctop u
  map_add' u v := by rw [transferLp_add, smul_add]
  map_smul' a u := by
    simp only [RingHom.id_apply, transferLp_smul, smul_comm (scaleConst c : ℂ) a]

theorem scaleLin_coeFn (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    (scaleLin hc0 hctop u : α → ℂ) =ᵐ[nu] fun x => (scaleConst c : ℂ) * (u : α → ℂ) x := by
  have hdef : scaleLin hc0 hctop u = (scaleConst c : ℂ) • transferLp hc0 hctop u := rfl
  rw [hdef]
  filter_upwards [Lp.coeFn_smul (scaleConst c : ℂ) (transferLp hc0 hctop u),
    transferLp_coeFn hc0 hctop u] with x h1 h2
  rw [h1]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [h2]

theorem norm_scaleLin (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    ‖scaleLin hc0 hctop u‖ = ‖u‖ := by
  have h1 : ‖scaleLin hc0 hctop u‖
      = scaleConst c * (eLpNorm (u : α → ℂ) 2 nu).toReal := by
    change ‖(scaleConst c : ℂ) • transferLp hc0 hctop u‖ = _
    rw [norm_smul, transferLp, Lp.norm_toLp]
    simp [abs_of_pos (scaleConst_pos hc0 hctop)]
  rw [h1, Lp.norm_def, eLpNorm_two_smul_measure hc0, ENNReal.toReal_mul]
  rfl

/-- **The scaling unitary** `L²(c·ν) ≃ₗᵢ[ℂ] L²(ν)`. -/
def scaleUnitary (hc0 : c ≠ 0) (hctop : c ≠ ⊤) : Lp ℂ 2 (c • nu) ≃ₗᵢ[ℂ] Lp ℂ 2 nu := by
  refine LinearIsometryEquiv.ofSurjective
    ⟨scaleLin hc0 hctop, norm_scaleLin hc0 hctop⟩ ?_
  intro w
  have hne : (scaleConst c : ℂ) ≠ 0 := by
    exact_mod_cast (scaleConst_pos hc0 hctop).ne'
  have hmem : MemLp (fun x => ((scaleConst c : ℂ))⁻¹ * (w : α → ℂ) x) 2 (c • nu) :=
    (memLp_two_smul_measure_iff hc0 hctop).2 ((Lp.memLp w).const_mul _)
  refine ⟨hmem.toLp _, Lp.ext ?_⟩
  have hcoe : ((hmem.toLp _ : Lp ℂ 2 (c • nu)) : α → ℂ)
      =ᵐ[nu] fun x => ((scaleConst c : ℂ))⁻¹ * (w : α → ℂ) x := by
    have h := hmem.coeFn_toLp
    rwa [Filter.EventuallyEq, ae_smul_measure_eq hc0] at h
  filter_upwards [scaleLin_coeFn hc0 hctop (hmem.toLp _), hcoe] with x h1 h2
  change (scaleLin hc0 hctop (hmem.toLp _) : α → ℂ) x = _
  rw [h1, h2]
  field_simp

theorem scaleUnitary_coeFn (hc0 : c ≠ 0) (hctop : c ≠ ⊤) (u : Lp ℂ 2 (c • nu)) :
    (scaleUnitary hc0 hctop u : α → ℂ)
      =ᵐ[nu] fun x => (scaleConst c : ℂ) * (u : α → ℂ) x :=
  scaleLin_coeFn hc0 hctop u

/-- **The scaling unitary intertwines the multiplication operators.** -/
theorem scaleUnitary_intertwines (hc0 : c ≠ 0) (hctop : c ≠ ⊤) {g : α → ℂ}
    (hg : MemLp g ⊤ (c • nu)) (u : Lp ℂ 2 (c • nu)) :
    (scaleUnitary hc0 hctop (multOp g hg u) : α → ℂ)
      =ᵐ[nu] fun x => g x * (scaleUnitary (nu := nu) hc0 hctop u : α → ℂ) x := by
  have h2 : (↑↑(multOp g hg u) : α → ℂ) =ᵐ[nu] fun x => g x * (u : α → ℂ) x := by
    have h := multOp_coeFn (μ := c • nu) g hg u
    rwa [Filter.EventuallyEq, ae_smul_measure_eq hc0] at h
  filter_upwards [scaleUnitary_coeFn hc0 hctop (multOp g hg u), h2,
    scaleUnitary_coeFn hc0 hctop u] with x h1 h2 h3
  rw [h1, h2, h3]
  ring

/-! ## 4. Normalizing a finite measure -/

theorem isProbabilityMeasure_inv_smul [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    IsProbabilityMeasure ((nu Set.univ)⁻¹ • nu) := by
  constructor
  rw [Measure.smul_apply, smul_eq_mul]
  exact ENNReal.inv_mul_cancel hne (measure_ne_top nu _)

/-- **HEADLINE (normalization).**  For a finite nonzero measure `ν` there is a unitary
from `L²` of the normalized probability measure `ν / ν(univ)` onto `L²(ν)` which
carries multiplication by an essentially bounded symbol to multiplication by the same
symbol.  So nothing in the multiplication algebra sees the total mass, and the models
of the classification list may be stated for probability measures without loss. -/
theorem normalized_multiplication_model [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    ∃ U : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu) ≃ₗᵢ[ℂ] Lp ℂ 2 nu,
      ∀ (g : α → ℂ) (hg : MemLp g ⊤ ((nu Set.univ)⁻¹ • nu))
        (u : Lp ℂ 2 ((nu Set.univ)⁻¹ • nu)),
        (U (multOp g hg u) : α → ℂ) =ᵐ[nu] fun x => g x * (U u : α → ℂ) x := by
  have hc0 : (nu Set.univ)⁻¹ ≠ 0 := ENNReal.inv_ne_zero.2 (measure_ne_top nu _)
  have hctop : (nu Set.univ)⁻¹ ≠ ⊤ := ENNReal.inv_ne_top.2 hne
  exact ⟨scaleUnitary hc0 hctop, fun g hg u => scaleUnitary_intertwines hc0 hctop hg u⟩

end BookProof.ChapterLpScaleMeasure

end
