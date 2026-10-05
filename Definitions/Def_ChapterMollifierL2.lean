import Mathlib

/-!
# Mollification converges in `L²`

The Kato-type essential self-adjointness theorem of `BookProof/ChapterDegKatoEsa.lean` is
proved by mollifying a deficiency vector, and the limit `ε → 0` needs one classical
ingredient that Mathlib does not carry: **mollification converges in `L²`**.

This module supplies it, in the sharp quantitative form

`‖∫ ρ(y)·(u(· − y) − u) dy‖₂ ≤ sup { ‖u(· − y) − u‖₂ : ρ(y) ≠ 0 }`,

together with the continuity of translation in `Lᵖ` that makes the right-hand side small:

* `eLpNorm_translate` — translations are `Lᵖ`-isometries;
* `tendsto_translate_cc` — continuity of translation for a continuous compactly supported
  function, by uniform continuity;
* `tendsto_translate_Lp` — continuity of translation in `Lᵖ`, by density of the compactly
  supported continuous functions;
* `eLpNorm_mollify_sub_le` — the displayed bound, by Cauchy–Schwarz against the probability
  density `ρ` and Tonelli;
* `tendsto_mollify_L2` — the conclusion: for a mollifier family whose supports shrink to
  `0`, the mollifications converge to `u` in `L²`.

Everything is stated for a finite-dimensional real normed space with an additive Haar
measure, so it applies verbatim to `L²(ℝᵈ)`.
-/
namespace BookProof.MollifierL2

end BookProof.MollifierL2
