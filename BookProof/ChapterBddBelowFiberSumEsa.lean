import Mathlib
import BookProof.ChapterBddBelowWallEsa
import BookProof.ChapterWallEsaSemibounded
import BookProof.ChapterDirectSumEsa

/-!
# QG-2 Case A, composed: a direct sum of bounded-below one-dimensional wall Hamiltonians

`BookProof/ChapterBddBelowWallEsa.lean` proves the one-dimensional input of
`CONSOLIDATED_PLAN.md`'s QG-2 **Case A**: `−d²/dx² + V` is essentially self-adjoint on the
compactly supported smooth core of `L²(ℝ)` for *every* smooth real potential bounded below,
with no growth and no sign hypothesis.  This module performs the **composition** step: it
glues an arbitrary family of such fibres into one operator on the orthogonal direct sum

`ℓ²(i : ι, L²(ℝ))`,   `H = ⊕ᵢ (−d²/dxᵢ² + Vᵢ)`,

and transports the three properties the plan asks of the composed object — essential
self-adjointness, the unitary flow it generates, and the lower bound on its quadratic form.

The gluing instrument is `BookProof.DirectSumEsa.dsOp_essentiallySelfAdjointOn` (a deficiency
space of an orthogonal direct sum is the direct sum of the fibre deficiency spaces), so no
relative bound, no comparison operator and no commutator estimate is needed; the whole
analytic content sits in the one-dimensional fibre theorem.

## What is proved

* `fiberCore`, `fiberSumHam` — the glued core `⊕ᵃˡᵍ Cc^∞(ℝ)` and the glued operator
  `⊕ᵢ (−d²/dxᵢ² + Vᵢ)`, with `fiberSumHam_single` and `fiberSumHam_symmetricOn`;
* `fiberCore_dense` — the glued core is dense;
* **`fiberSumHam_essentiallySelfAdjoint_of_bddBelow`** — the composed operator is
  essentially self-adjoint as soon as *each* fibre potential is bounded below (each with its
  own constant); `fiberSumHam_essentiallySelfAdjoint_of_bddBelow'` is the `BddBelow` form and
  `fiberSumHam_essentiallySelfAdjoint_of_nonneg` the non-negative case;
* `fiberSumHam_stone_flow` — the composed operator therefore has a unique self-adjoint
  extension and generates the unitary group `e^{−itH}`;
* **`fiberSumHam_semibounded`** — with a *uniform* lower bound `Vᵢ ≥ −c` the quadratic form
  of the composed operator is bounded below by `−c` (the fibrewise Green identity of
  `BookProof.WallEsaSemibounded`, summed over the fibres), and `fiberSumHam_nonneg_form`
  for `Vᵢ ≥ 0`;
* `qgFiberSum_esa`, `qgFiberSum_nonneg_form` — the physical instance of QG-3.3's derived
  fibre list: `d` shear directions carrying harmonic walls `ωᵢ² xᵢ²` together with one
  scalaron direction carrying the Starobinsky wall `starobinskyV M α`.

## Honest boundary

The decomposition is an **orthogonal direct sum** of one-dimensional fibres, not a tensor
product: the space is `ℓ²(ι, L²(ℝ))`, and this module says nothing about `−Δ + V` on
`L²(ℝ^d)` (whose deficiency analysis would need multi-dimensional elliptic regularity, which
is not available here).  Uniform boundedness below is needed only for the *form* bound; for
essential self-adjointness the constants may vary from fibre to fibre.  Nothing here concerns
the wrong-sign conformal direction, which is Case B and where the conclusion is false
(`BookProof/ChapterConformalFiberDeficiency.lean`).
-/

namespace BookProof.BddBelowFiberSumEsa

open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

/-- The one-particle space of the composed model: the orthogonal direct sum of one copy of
`L²(ℝ)` per fibre. -/
abbrev fiberSpace (ι : Type*) := lp (fun _ : ι => Lp ℂ 2 (volume : Measure ℝ)) 2

/-- The glued core: the algebraic direct sum of the fibre cores of compactly supported
smooth functions. -/
def fiberCore (ι : Type*) : Submodule ℂ (fiberSpace ι) := dsCore (fun _ : ι => ccDomain ℝ)

/-- **The composed operator** `⊕ᵢ (−d²/dxᵢ² + Vᵢ)` on the glued core. -/
def fiberSumHam (V : ι → ℝ → ℝ) (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) :
    fiberCore ι →ₗ[ℂ] fiberSpace ι :=
  dsOp (fun i => wallHam (V i) (hV i))

theorem fiberSumHam_single [DecidableEq ι] (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (i : ι) (u : ccDomain ℝ) :
    fiberSumHam V hV ⟨lp.single 2 i (u : Lp ℂ 2 (volume : Measure ℝ)),
        single_mem_dsCore (D := fun _ : ι => ccDomain ℝ) i u⟩
      = lp.single 2 i (wallHam (V i) (hV i) u) :=
  dsOp_single (D := fun _ : ι => ccDomain ℝ) (fun i => wallHam (V i) (hV i)) i u

theorem fiberSumHam_symmetricOn (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) :
    SymmetricOn (fiberCore ι) (fiberSumHam V hV) :=
  dsOp_symmetricOn _ (fun i => wallHam_symmetricOn (V i) (hV i))

theorem fiberCore_dense :
    Dense ((fiberCore ι : Submodule ℂ (fiberSpace ι)) : Set (fiberSpace ι)) :=
  dsCore_dense (fun _ => ccDomain_dense)

/-! ## Essential self-adjointness of the composed operator -/

/-- **The composition step of QG-2 Case A.**  If every fibre potential is smooth and bounded
below — each with its own constant — the direct sum `⊕ᵢ (−d²/dxᵢ² + Vᵢ)` is essentially
self-adjoint on the algebraic direct sum of the compactly supported smooth cores. -/
theorem fiberSumHam_essentiallySelfAdjoint_of_bddBelow (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, ∃ K : ℝ, ∀ x, -K ≤ V i x) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) := by
  refine dsOp_essentiallySelfAdjointOn _ (fun i => ?_)
  obtain ⟨K, hK⟩ := hbdd i
  exact wallHam_essentiallySelfAdjoint_of_bddBelow (V i) (hV i) hK

/-- The same with the fibre hypotheses phrased as `BddBelow (Set.range (V i))`. -/
theorem fiberSumHam_essentiallySelfAdjoint_of_bddBelow' (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, BddBelow (Set.range (V i))) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) := by
  refine fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV (fun i => ?_)
  obtain ⟨c, hc⟩ := hbdd i
  exact ⟨-c, fun x => by simpa using hc ⟨x, rfl⟩⟩

/-- The non-negative case. -/
theorem fiberSumHam_essentiallySelfAdjoint_of_nonneg (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (hnn : ∀ i x, 0 ≤ V i x) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) :=
  fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV
    (fun i => ⟨0, fun x => by simpa using hnn i x⟩)

/-- **The unitary flow of the composed operator.** -/
theorem fiberSumHam_stone_flow (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, ∃ K : ℝ, ∀ x, -K ≤ V i x) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint (fiberSpace ι))
      (U : ℝ → (fiberSpace ι →L[ℂ] fiberSpace ι)),
      EsaClosure.IsSelfAdjointExtension (fiberSumHam V hV) T.op ∧ StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ fiberCore_dense (fiberSumHam_symmetricOn V hV)
    (fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV hbdd)

/-! ## The quadratic form of the composed operator -/

/-- **A fibrewise lower bound on the quadratic forms glues.**  If every fibre form is bounded
below by the *same* constant `−c`, so is the form of the direct sum: both the pairing and the
norm square of a vector of the glued core are the (finite) sums of their fibre values. -/
theorem dsOp_semibounded {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}
    (H : ∀ i, D i →ₗ[ℂ] G i) {c : ℝ} (h : ∀ i, SemiboundedBelowOn (D i) (H i) c) :
    SemiboundedBelowOn (dsCore D) (dsOp H) c := by
  classical
  intro v
  set x : lp G 2 := (v : lp G 2) with hx
  set S : Finset ι := v.2.1.toFinset with hS
  have hzero : ∀ i ∉ S, (x : ∀ i, G i) i = 0 := by
    intro i hi
    by_contra hne
    exact hi (by simpa [hS] using hne)
  have hpair : (inner ℂ (dsOp H v) x : ℂ)
      = ∑ i ∈ S, (inner ℂ (H i ⟨(x : ∀ i, G i) i, v.2.2 i⟩) ((x : ∀ i, G i) i) : ℂ) := by
    rw [lp.inner_eq_tsum]
    refine tsum_eq_sum fun i hi => ?_
    have h0 : (⟨(x : ∀ i, G i) i, v.2.2 i⟩ : D i) = 0 := Subtype.ext (hzero i hi)
    simp [dsOp_coe, hzero i hi]
  have hnorm : (‖x‖ : ℝ) ^ 2 = ∑ i ∈ S, ‖(x : ∀ i, G i) i‖ ^ 2 := by
    have h1 : (inner ℂ x x : ℂ) = ∑ i ∈ S, (inner ℂ ((x : ∀ i, G i) i) ((x : ∀ i, G i) i) : ℂ) := by
      rw [lp.inner_eq_tsum]
      refine tsum_eq_sum fun i hi => ?_
      simp [hzero i hi]
    have h2 := congrArg Complex.re h1
    have h3 : (inner ℂ x x : ℂ).re = ‖x‖ ^ 2 := inner_self_eq_norm_sq (𝕜 := ℂ) x
    rw [h3, Complex.re_sum] at h2
    rw [h2]
    exact Finset.sum_congr rfl fun i _ => inner_self_eq_norm_sq (𝕜 := ℂ) _
  have hfib : ∀ i ∈ S, -c * ‖(x : ∀ i, G i) i‖ ^ 2
      ≤ (inner ℂ (H i ⟨(x : ∀ i, G i) i, v.2.2 i⟩) ((x : ∀ i, G i) i) : ℂ).re := by
    intro i _
    exact h i ⟨(x : ∀ i, G i) i, v.2.2 i⟩
  have hsum := Finset.sum_le_sum hfib
  rw [hpair, Complex.re_sum, hnorm, Finset.mul_sum]
  exact hsum

/-- **The composed form bound.**  With a lower bound `Vᵢ ≥ −c` holding uniformly in the
fibre index, the quadratic form of `⊕ᵢ (−d²/dxᵢ² + Vᵢ)` is bounded below by `−c`. -/
theorem fiberSumHam_semibounded (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) {c : ℝ} (hc : ∀ i x, -c ≤ V i x) :
    SemiboundedBelowOn (fiberCore ι) (fiberSumHam V hV) c :=
  dsOp_semibounded _ (fun i => wallHamBddBelow_semibounded (V i) (hV i) (hc i))

/-- The non-negative case of the composed form bound. -/
theorem fiberSumHam_nonneg_form (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (hnn : ∀ i x, 0 ≤ V i x) :
    SemiboundedBelowOn (fiberCore ι) (fiberSumHam V hV) 0 :=
  fiberSumHam_semibounded V hV (fun i x => by simpa using hnn i x)

/-! ## The physical instance: shear walls plus the scalaron wall -/

/-- The fibre list of QG-3.3's derived reduction: `d` shear directions carrying the harmonic
walls `ωᵢ² xᵢ²`, and one scalaron direction carrying the Starobinsky wall. -/
def qgFiberV (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) : Option (Fin d) → ℝ → ℝ
  | none => fun phi => BookProof.Starobinsky.starobinskyV M alpha phi
  | some i => fun x => omega i ^ 2 * x ^ 2

theorem contDiff_qgFiberV (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) (i : Option (Fin d)) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (qgFiberV M alpha omega i) := by
  cases i with
  | none => exact BookProof.ScalaronEsa.contDiff_starobinskyV M alpha
  | some i => exact contDiff_const.mul (contDiff_id.pow 2)

theorem qgFiberV_nonneg {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ)
    (i : Option (Fin d)) (x : ℝ) : 0 ≤ qgFiberV M alpha omega i x := by
  cases i with
  | none => exact BookProof.Starobinsky.starobinskyV_nonneg halpha x
  | some i => exact mul_nonneg (sq_nonneg _) (sq_nonneg _)

/-- **The composed QG fibre model is essentially self-adjoint.**  Every fibre carries the
positive kinetic term `−d²/dxᵢ²` and a non-negative wall, so QG-2 Case A applies fibrewise
and the gluing is unconditional. -/
theorem qgFiberSum_esa {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ) :
    EssentiallySelfAdjointOn (fiberCore (Option (Fin d)))
      (fiberSumHam (qgFiberV M alpha omega) (contDiff_qgFiberV M alpha omega)) :=
  fiberSumHam_essentiallySelfAdjoint_of_nonneg _ _ (qgFiberV_nonneg halpha omega)

/-- The composed QG fibre model has a non-negative quadratic form. -/
theorem qgFiberSum_nonneg_form {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ) :
    SemiboundedBelowOn (fiberCore (Option (Fin d)))
      (fiberSumHam (qgFiberV M alpha omega) (contDiff_qgFiberV M alpha omega)) 0 :=
  fiberSumHam_nonneg_form _ _ (qgFiberV_nonneg halpha omega)

end

end BookProof.BddBelowFiberSumEsa
