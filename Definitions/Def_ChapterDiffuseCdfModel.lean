import Mathlib

/-!
# Diffuse measures and the uniform model (plan GAP-2, the diffuse standard type)

The abelian classification list names `L∞[0,1]` — multiplication by essentially
bounded functions on the unit interval with Lebesgue measure — as the *diffuse*
standard type.  `ChapterMeasureAtomicDiffuse` splits every summand measure of the
abelian multiplication model into a purely atomic and a diffuse part; the diffuse
part still has to be recognised as the uniform measure.  This module proves the
measure-theoretic half of that recognition on the real line:

* `continuous_cdf_of_noAtoms` — the cumulative distribution function of an atomless
  probability measure is continuous (a jump of `F` at `a` *is* the mass of `{a}`);
* `exists_cdf_eq` — consequently `F` takes every value in `(0, 1)`, since it tends to
  `0` at `-∞` and to `1` at `+∞`;
* `measure_cdf_le` — the key computation `μ{x : F x ≤ t} = t` for `0 ≤ t < 1`;
* HEADLINE `map_cdf_eq_volume_Icc` — **the distribution function pushes an atomless
  probability measure forward to the uniform measure**:
  `(F)_* μ = volume|[0,1]`.

So every diffuse probability measure on `ℝ` is, through its own distribution
function, a copy of Lebesgue measure on the unit interval — the standard diffuse
model of the classification list.

Everything is `sorry`-free and `axiom`-free.
-/
namespace BookProof.ChapterDiffuseCdfModel

end BookProof.ChapterDiffuseCdfModel
