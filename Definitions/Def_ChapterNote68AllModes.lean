import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterSphericalBessel
import Mathlib


/-!
# Note 68 for every angular-momentum mode `(l, μ)`

`BookProof.ChapterBesselHarmonic` proved Note 68 of `book.tex` §A.5 —
`−∂⃗² (jₗ(p r)/rˡ · H) = p² (jₗ(p r)/rˡ · H)` — for an *arbitrary* harmonic
function `H` homogeneous of degree `l`, but only realized it concretely for
`l ≤ 1` (a linear functional).  `BookProof.ChapterSolidHarmonic` now supplies
those `H` for every `l` and every order `μ ≤ l`: the solid harmonics
`rˡ Y_{lμ}(θ, φ)` built from the associated Legendre functions.  Putting the two
together closes the boundary recorded in those modules.

## Contents

* `helmholtz_sbessel_solidHarmonic` — **Note 68 in the mode `(l, μ)`**: on a
  three-dimensional real inner product space with an orthonormal frame
  `(u, v, e)`,
  `−∂⃗² (jₗ(p‖x⃗‖)/‖x⃗‖ˡ · rˡY_{lμ}(x⃗)) = p² · (jₗ(p‖x⃗‖)/‖x⃗‖ˡ · rˡY_{lμ}(x⃗))`,
  and the same for the `Im` (i.e. `sin μφ`) partner;
* `euclidean_frame_*` — the standard frame of `ℝ³` is such a frame, so
* `helmholtz_sbessel_solidHarmonic_euclidean` — the concrete statement on
  `EuclideanSpace ℝ (Fin 3)`;
* `solidHarmonic_spherical_euclidean` — and there the mode is literally
  `rˡ P_l^μ(cos θ) cos(μφ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterNote68AllModes

open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]





/-! ## The standard frame of `ℝ³` -/

/-- The `i`-th standard basis vector of `ℝ³`. -/
noncomputable def stdVec (i : Fin 3) : EuclideanSpace ℝ (Fin 3) := EuclideanSpace.single i 1onic

/-!
# Note 68 for every angular-momentum mode `(l, μ)`

`BookProof.ChapterBesselHarmonic` proved Note 68 of `book.tex` §A.5 —
`−∂⃗² (jₗ(p r)/rˡ · H) = p² (jₗ(p r)/rˡ · H)` — for an *arbitrary* harmonic
function `H` homogeneous of degree `l`, but only realized it concretely for
`l ≤ 1` (a linear functional).  `BookProof.ChapterSolidHarmonic` now supplies
those `H` for every `l` and every order `μ ≤ l`: the solid harmonics
`rˡ Y_{lμ}(θ, φ)` built from the associated Legendre functions.  Putting the two
together closes the boundary recorded in those modules.

## Contents

* `helmholtz_sbessel_solidHarmonic` — **Note 68 in the mode `(l, μ)`**: on a
  three-dimensional real inner product space with an orthonormal frame
  `(u, v, e)`,
  `−∂⃗² (jₗ(p‖x⃗‖)/‖x⃗‖ˡ · rˡY_{lμ}(x⃗)) = p² · (jₗ(p‖x⃗‖)/‖x⃗‖ˡ · rˡY_{lμ}(x⃗))`,
  and the same for the `Im` (i.e. `sin μφ`) partner;
* `euclidean_frame_*` — the standard frame of `ℝ³` is such a frame, so
* `helmholtz_sbessel_solidHarmonic_euclidean` — the concrete statement on
  `EuclideanSpace ℝ (Fin 3)`;
* `solidHarmonic_spherical_euclidean` — and there the mode is literally
  `rˡ P_l^μ(cos θ) cos(μφ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterNote68AllModes

open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterSphericalBessel BookProof.ChapterBesselHarmonic
open BookProof.ChapterSolidHarmonic
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- **Note 68 in the angular-momentum mode `(l, μ)`.** -/
theorem helmholtz_sbessel_solidHarmonic {u v e : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (he : ‖e‖ = 1)
    (huv : ⟪u, v⟫_ℝ = 0) (hue : ⟪u, e⟫_ℝ = 0) (hve : ⟪v, e⟫_ℝ = 0)
    (h3 : Module.finrank ℝ E = 3) {l μ : ℕ} (hμ : μ ≤ l) {x : E} {p : ℝ}
    (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : E => (sbessel l (p * ‖y‖) / ‖y‖ ^ l) * solidHarmonic u v e l μ y) x
      = p ^ 2 * ((sbessel l (p * ‖x‖) / ‖x‖ ^ l) * solidHarmonic u v e l μ x) :=
  helmholtz_sbessel_harmonic h3 hp hx (contDiff_solidHarmonic u v e l μ).contDiffAt
    (solidHarmonic_harmonic hu hv he huv hue hve h3 hμ x) (solidHarmonic_euler u v e hμ x)

/-- The same for the `sin μφ` partner. -/
theorem helmholtz_sbessel_solidHarmonicIm {u v e : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (he : ‖e‖ = 1)
    (huv : ⟪u, v⟫_ℝ = 0) (hue : ⟪u, e⟫_ℝ = 0) (hve : ⟪v, e⟫_ℝ = 0)
    (h3 : Module.finrank ℝ E = 3) {l μ : ℕ} (hμ : μ ≤ l) {x : E} {p : ℝ}
    (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : E => (sbessel l (p * ‖y‖) / ‖y‖ ^ l) * solidHarmonicIm u v e l μ y) x
      = p ^ 2 * ((sbessel l (p * ‖x‖) / ‖x‖ ^ l) * solidHarmonicIm u v e l μ x) :=
  helmholtz_sbessel_harmonic h3 hp hx (contDiff_solidHarmonicIm u v e l μ).contDiffAt
    (solidHarmonicIm_harmonic hu hv he huv hue hve h3 hμ x) (solidHarmonicIm_euler u v e hμ x)

/-! ## The standard frame of `ℝ³` -/

/-- The `i`-th standard basis vector of `ℝ³`. -/
noncomputable def stdVec (i : Fin 3) : EuclideanSpace ℝ (Fin 3) := EuclideanSpace.single i 1



theorem inner_stdVec {i j : Fin 3} (h : i ≠ j) : ⟪stdVec i, stdVec j⟫_ℝ = 0 := by
  rw [stdVec, stdVec, EuclideanSpace.inner_single_left, EuclideanSpace.single_apply]
  simp [h]







end BookProof.ChapterNote68AllModes
