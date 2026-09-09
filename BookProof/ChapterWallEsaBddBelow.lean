import Mathlib
import BookProof.ChapterScalaronWallEsa
import BookProof.ChapterKatoRellichDeficiency

/-!
# `−d²/dx² + V` for every smooth potential that is bounded below

`BookProof/ChapterScalaronWallEsa.lean` proves that `−d²/dx² + V` is essentially
self-adjoint on the compactly supported smooth core of `L²(ℝ)` for every smooth
**non-negative** potential — with no growth restriction, so in particular for the
exponentially growing Einstein-frame scalaron wall.

The non-negativity in that statement is not a real restriction: a *constant* is a bounded
symmetric perturbation, and bounded symmetric perturbations preserve essential
self-adjointness (`BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded`).  This
module performs the shift and records the consequences:

* `wallHam_add_const` — the operator identity `wallHam (V + c) = wallHam V + c`;
* **`wallHam_essentiallySelfAdjoint_of_bddBelow`** — `−d²/dx² + V` is essentially
  self-adjoint on the compactly supported smooth core for every smooth `V` bounded below,
  again with no growth restriction above;
* `wallHam_stone_flow_of_bddBelow` — the resulting unitary group `e^{−itH}`;
* the semiboundedness the Hashimoto/SIRK shift-invert scheme needs is carried by the
  shift itself: the quadratic form of `wallHam V hV` is bounded below by `-c` whenever
  `V ≥ -c`, so the closed operator selected by the closure is the semibounded one the
  scheme works with; the packaging lemma `wallHamBddBelow_semibounded` that makes this
  precise is proved in `BookProof/ChapterWallEsaSemibounded.lean`;
* the physical instances: the scalaron wall plus an arbitrary bounded-below smooth
  addition (`scalaronPlus_esa`), and the harmonic-oscillator sum
  `−d²/dx² + x²/4 + V` (`oscillatorPlus_esa`).
-/

namespace BookProof.WallEsaBddBelow

open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

noncomputable section

/-- Multiplication by a real constant, as a bounded operator on `L²(ℝ)`. -/
def constOp (c : ℝ) : Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  ((c : ℂ)) • ContinuousLinearMap.id ℂ (Lp ℂ 2 (volume : Measure ℝ))

lemma constOp_symmetric (c : ℝ) (x y : Lp ℂ 2 (volume : Measure ℝ)) :
    (inner ℂ (constOp c x) y : ℂ) = inner ℂ x (constOp c y) := by
  simp only [constOp, ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
    inner_smul_left, inner_smul_right, Complex.conj_ofReal]

/-- **Adding a constant to the potential adds a constant to the operator.** -/
lemma wallHam_add_const (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (c : ℝ) :
    wallHam (fun x => V x + c) (hV.add contDiff_const)
      = wallHam V hV + ((constOp c).toLinearMap ∘ₗ (ccDomain ℝ).subtype) := by
  refine LinearMap.ext fun x => ?_
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective x
  have hpot : opCc (fun x => V x + c) (hV.add contDiff_const) (ccEquiv ℝ f)
      = opCc V hV (ccEquiv ℝ f) + constOp c ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 _) := by
    rw [opCc_apply, opCc_apply, ccEquiv_coe]
    refine MeasureTheory.Lp.ext ?_
    filter_upwards [(mulCc (fun x => V x + c) (hV.add contDiff_const) f).coeFn_toLp 2
        (volume : Measure ℝ),
      (mulCc V hV f).coeFn_toLp 2 (volume : Measure ℝ),
      (f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ),
      MeasureTheory.Lp.coeFn_add ((mulCc V hV f).toLp 2 (volume : Measure ℝ))
        (constOp c ((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ))),
      MeasureTheory.Lp.coeFn_smul ((c : ℂ))
        ((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ))] with x h1 h2 h3 h4 h5
    have h5' : ((constOp c ((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ)) :
          Lp ℂ 2 (volume : Measure ℝ)) : ℝ → ℂ) x
        = (c : ℂ) * (((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ) :
          Lp ℂ 2 (volume : Measure ℝ)) : ℝ → ℂ) x := by
      simpa [constOp, smul_eq_mul] using h5
    rw [h1, h4, Pi.add_apply, h2, h5', h3]
    simp only [mulCc_apply]
    push_cast
    ring
  simp only [wallHam, LinearMap.add_apply, hpot, LinearMap.coe_comp, Function.comp_apply,
    Submodule.subtype_apply, ContinuousLinearMap.coe_coe]
  abel

/-- **`−d²/dx² + V` is essentially self-adjoint on the compactly supported smooth core of
`L²(ℝ)` for every smooth potential that is bounded below.**  No growth restriction is
imposed from above: the potential may grow exponentially (the scalaron wall) or faster. -/
theorem wallHam_essentiallySelfAdjoint_of_bddBelow (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by
  have hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x => V x + c := hV.add contDiff_const
  have hnn : ∀ x, 0 ≤ V x + c := fun x => by linarith [hVc x]
  have hesa := wallHam_essentiallySelfAdjoint (fun x => V x + c) hW hnn
  have hsymm := wallHam_symmetricOn (fun x => V x + c) hW
  have hkey := essentiallySelfAdjointOn_add_bounded (wallHam (fun x => V x + c) hW) hsymm hesa
    (constOp (-c)) (constOp_symmetric (-c))
  have hid : wallHam (fun x => V x + c) hW
      + ((constOp (-c)).toLinearMap ∘ₗ (ccDomain ℝ).subtype) = wallHam V hV := by
    have h := wallHam_add_const V hV c
    refine LinearMap.ext fun x => ?_
    have hx := congrArg (fun T : ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) => T x) h
    simp only [LinearMap.add_apply, LinearMap.coe_comp, Function.comp_apply,
      Submodule.subtype_apply, ContinuousLinearMap.coe_coe, constOp,
      ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply] at hx ⊢
    rw [hx]
    push_cast
    module
  rwa [hid] at hkey

/-- **The unitary flow of `−d²/dx² + V` for a smooth potential bounded below.** -/
theorem wallHam_stone_flow_of_bddBelow (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 (volume : Measure ℝ)))
      (U : ℝ → (Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ))),
      IsSelfAdjointExtension (wallHam V hV) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ ccDomain_dense (wallHam_symmetricOn V hV)
    (wallHam_essentiallySelfAdjoint_of_bddBelow V hV hVc)

/-! ## Instances -/

/-- **The scalaron wall plus an arbitrary smooth bounded-below addition.**  The Starobinsky
wall itself is non-negative; this allows an extra term of either sign, for instance the
conformal-mode parabola, provided only that it is bounded below. -/
theorem scalaronPlus_esa {M alpha : ℝ} (halpha : 0 < alpha) (W : ℝ → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) {c : ℝ} (hWc : ∀ x, -c ≤ W x) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun phi => BookProof.Starobinsky.starobinskyV M alpha phi + W phi)
        ((BookProof.ScalaronEsa.contDiff_starobinskyV M alpha).add hW)) :=
  wallHam_essentiallySelfAdjoint_of_bddBelow _ _
    (c := c) fun phi => by
      have h1 := BookProof.Starobinsky.starobinskyV_nonneg (M := M) halpha phi
      have h2 := hWc phi
      linarith

/-- **The harmonic oscillator plus an arbitrary smooth bounded-below potential**,
`−d²/dx² + x²/4 + V`, is essentially self-adjoint on the compactly supported smooth core.
Unlike the Hermite-core route, no relative bound between `V` and the oscillator is
required — which is exactly what fails for the exponential wall. -/
theorem oscillatorPlus_esa (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun x => x ^ 2 / 4 + V x)
        (((contDiff_id.pow 2).div_const 4).add hV)) :=
  wallHam_essentiallySelfAdjoint_of_bddBelow _ _ (c := c) fun x => by
    have h1 : (0 : ℝ) ≤ x ^ 2 / 4 := by positivity
    have h2 := hVc x
    linarith

end

end BookProof.WallEsaBddBelow
