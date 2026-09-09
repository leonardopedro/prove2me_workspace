import Mathlib
import BookProof.ChapterFarisLavine

/-!
# The conformal-direction sign flip: deficiency under `H ↦ −H` and real shifts

Plan item **QG-2 / 29f Case B** of `CONSOLIDATED_PLAN.md` rests on a sign
bookkeeping step that the plan performs informally: the densitized conformal
fiber

```text
F = c·∂²_y + V(y) + c₀        (c > 0: the *wrong-sign* kinetic of the
                               tetrad-determinant direction)
```

is the negative of

```text
−F = c·(−∂²_y) − V(y) − c₀,
```

a *positive*-kinetic operator whose potential is `−V`, i.e. the class the
project's own sign warning (`ChapterWaveUnboundedPotential`, lines 48–56)
marks as the failure class when `V → +∞` (as it does at the scalaron wall).
This module proves that bookkeeping step, at the level of the deficiency
predicates the rest of the tree uses:

* `deficiencyTrivialAt_neg` — `H ↦ −H` reflects the spectral parameter:
  the adjoint deficiency of `−H` at `z` is trivial iff that of `H` at `−z` is;
* `essentiallySelfAdjointOn_neg` / `essentiallySelfAdjointOn_neg_iff` —
  consequently essential self-adjointness is **invariant** under the global
  sign flip (the pair `{i, −i}` is swapped);
* `wrongSignKinetic_esa_iff` — the statement in the form the plan uses:
  for a kinetic operator `K` and a potential `V`, the wrong-sign fiber
  `−K + V` is essentially self-adjoint **iff** the positive-kinetic operator
  `K − V` is.  So no choice of sign convention can rescue a fiber whose
  flipped potential `−V` is in the failure class;
* `deficiencyTrivialAt_add_real` — adding a real constant `c₀` translates the
  spectral parameter, so the constant in the fiber is immaterial to the
  analysis;
* `symmetricOn_neg`, `symmetricOn_add_real` — symmetry is preserved by both
  operations, so the flipped operator is still a legitimate candidate.

Nothing here decides Case B: it makes the *reduction* rigorous, so the open
analytic question is exactly the one the plan names (whether the
positive-kinetic operator with the unbounded-below potential `−V` has trivial
deficiency — it does not, by the standard limit-circle analysis, which is not
formalized here).

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ConformalSignFlip

open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-- **The sign flip reflects the spectral parameter.**  The adjoint deficiency
space of `−H` at `z` is trivial exactly when that of `H` at `−z` is. -/
theorem deficiencyTrivialAt_neg (H : D →ₗ[ℂ] F) (z : ℂ) :
    DeficiencyTrivialAt D (-H) z ↔ DeficiencyTrivialAt D H (-z) := by
  constructor
  · intro h w hw
    refine h w fun v => ?_
    have hv := hw v
    rw [LinearMap.neg_apply, inner_neg_left, hv]
    ring
  · intro h w hw
    refine h w fun v => ?_
    have hv := hw v
    rw [LinearMap.neg_apply, inner_neg_left] at hv
    linear_combination -hv

/-- **Essential self-adjointness is invariant under the global sign flip.** -/
theorem essentiallySelfAdjointOn_neg {H : D →ₗ[ℂ] F}
    (h : EssentiallySelfAdjointOn D H) : EssentiallySelfAdjointOn D (-H) := by
  refine ⟨?_, ?_⟩
  · rw [deficiencyTrivialAt_neg]
    exact h.2
  · rw [deficiencyTrivialAt_neg, neg_neg]
    exact h.1

theorem essentiallySelfAdjointOn_neg_iff (H : D →ₗ[ℂ] F) :
    EssentiallySelfAdjointOn D (-H) ↔ EssentiallySelfAdjointOn D H := by
  refine ⟨fun h => ?_, essentiallySelfAdjointOn_neg⟩
  have := essentiallySelfAdjointOn_neg h
  rwa [neg_neg] at this

/-- **The plan's Case-B reduction.**  The wrong-sign-kinetic fiber `−K + V` is
essentially self-adjoint iff the positive-kinetic operator `K − V` is: the
conformal direction's failure or success is decided by the *flipped* potential
`−V`, not by the sign convention. -/
theorem wrongSignKinetic_esa_iff (K V : D →ₗ[ℂ] F) :
    EssentiallySelfAdjointOn D (-K + V) ↔ EssentiallySelfAdjointOn D (K - V) := by
  have hneg : -(K - V) = -K + V := by
    ext x
    simp only [LinearMap.neg_apply, LinearMap.sub_apply, LinearMap.add_apply]
    abel
  rw [← hneg, essentiallySelfAdjointOn_neg_iff]

/-- **A real shift translates the spectral parameter.**  Adding the real
constant `c₀` to the fiber moves the deficiency question from `z` to `z − c₀`;
in particular the constant plays no role in whether the deficiency spaces are
trivial at *some* non-real parameter. -/
theorem deficiencyTrivialAt_add_real (H : D →ₗ[ℂ] F) (c : ℝ) (z : ℂ) :
    DeficiencyTrivialAt D (H + (c : ℂ) • D.subtype) z
      ↔ DeficiencyTrivialAt D H (z - (c : ℂ)) := by
  have key : ∀ (w : F) (v : D),
      (inner ℂ ((H + (c : ℂ) • D.subtype) v) w : ℂ)
        = (inner ℂ (H v) w : ℂ) + (c : ℂ) * inner ℂ (v : F) w := by
    intro w v
    rw [LinearMap.add_apply, inner_add_left, LinearMap.smul_apply, inner_smul_left,
      Submodule.subtype_apply, Complex.conj_ofReal]
  constructor
  · intro h w hw
    refine h w fun v => ?_
    rw [key w v, hw v]
    ring
  · intro h w hw
    refine h w fun v => ?_
    have hv := hw v
    rw [key w v] at hv
    linear_combination hv

/-- Symmetry is preserved by the sign flip. -/
theorem symmetricOn_neg {H : D →ₗ[ℂ] F} (h : SymmetricOn D H) : SymmetricOn D (-H) := by
  intro x y
  rw [LinearMap.neg_apply, LinearMap.neg_apply, inner_neg_left, inner_neg_right, h x y]

/-- Symmetry is preserved by adding a real constant. -/
theorem symmetricOn_add_real {H : D →ₗ[ℂ] F} (h : SymmetricOn D H) (c : ℝ) :
    SymmetricOn D (H + (c : ℂ) • D.subtype) := by
  intro x y
  rw [LinearMap.add_apply, LinearMap.add_apply, inner_add_left, inner_add_right,
    LinearMap.smul_apply, LinearMap.smul_apply, inner_smul_left, inner_smul_right,
    Submodule.subtype_apply, Submodule.subtype_apply, Complex.conj_ofReal, h x y]

/-! ## Axiom audit -/

#print axioms deficiencyTrivialAt_neg
#print axioms essentiallySelfAdjointOn_neg_iff
#print axioms wrongSignKinetic_esa_iff
#print axioms deficiencyTrivialAt_add_real
#print axioms symmetricOn_neg
#print axioms symmetricOn_add_real

end BookProof.ConformalSignFlip
