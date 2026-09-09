import Mathlib
import BookProof.ChapterYangMillsFieldStrength

/-!
# Chapter "Timepiece and the Gribov ambiguity", §"Free electromagnetic field: an exact example" —
the abelian reduction of the field strength

Source: `book.tex`, chapter *"Timepiece and the Gribov ambiguity"*,
§*"Free electromagnetic field: an exact example"* (line ~7413):

> *"While the free electromagnetic field is an abelian gauge theory and thus it
> is somewhat simpler than a Yang-Mills theory (for instance, there is no Gribov
> ambiguity), it has the crucial advantage that the time-evolution has an exact
> solution, because the Hamiltonian is quadratic in the fields. … The
> extrapolation of the results of the previous section to the electromagnetism is
> straightforward … we set the structure constants `f_{abc}` to zero. …
> Through time-evolution (in the Weyl gauge), we also have the local self-adjoint
> operator `∂×π`, i.e. the curl of the Electric Field."*

This continues `ChapterYangMillsFieldStrength.lean` (the non-abelian field
strength `F_{jk} = δ_j a_k - δ_k a_j + [a_j, a_k]`) by specializing to the
**abelian (electromagnetic) case**, where the connection components commute
(equivalently the structure constants `f_{abc}` vanish).  In that case:

* the quadratic `[a_j, a_k]` correction drops out, so the field strength reduces
  to the ordinary **exterior derivative / curl** `F_{jk} = ∂_j A_k - ∂_k A_j`,
  which is *linear* in the fields — this is exactly why "the Hamiltonian is
  quadratic in the fields" and admits an exact solution;
* this abelian field strength is **gauge invariant** under the abelian gauge
  transformation `A_j ↦ A_j + ∂_j θ` (the curl of a gradient vanishes),
  which is the abelian statement of "there is no Gribov ambiguity";
* the field strength / curl of *self-adjoint* operator fields (e.g. the curl of
  the electric field `∂×π`) is again **self-adjoint**, i.e. a genuine local
  observable.

## Main statements

* `emFieldStrength` — the abelian field strength `F_{jk} = δ_j (A_k) - δ_k (A_j)`
  (the exterior derivative / a single curl component);
* `emFieldStrength_antisymm` — `F_{jk} = - F_{kj}`;
* `emFieldStrength_gauge_invariant` — invariance under `A_j ↦ A_j + δ_j θ`
  (curl of a gradient vanishes; the abelian "no Gribov ambiguity");
* `fieldStrengthMul_eq_emFieldStrength_of_commute` — when the connection
  components commute, the non-abelian field strength of
  `ChapterYangMillsFieldStrength` equals the abelian one (the `f = 0` reduction);
* `Fbook_eq_emFieldStrength_of_commute` — the same reduction for the book's
  coupled field strength `Fbook`;
* `emFieldStrength_isSelfAdjoint` — the curl of self-adjoint operator fields is
  self-adjoint (the book's local self-adjoint `∂×π`).
-/

namespace BookProof.FreeEMField

open BookProof.YangMillsFieldStrength

section Abstract

variable {R : Type*} [Ring R]

/-- The **abelian field strength** (a single curl component / exterior
derivative) `F_{jk} = δ_j (A_k) - δ_k (A_j)`, where `δ_j` is the partial
derivative `∂_j` and `A_j` is the gauge potential.  This is the `f_{abc} = 0`
specialization of the non-abelian `fieldStrengthMul`. -/
def emFieldStrength (δ : Fin 3 → R → R) (A : Fin 3 → R) (j k : Fin 3) : R :=
  δ j (A k) - δ k (A j)

/-- The abelian field strength is antisymmetric: `F_{jk} = - F_{kj}`. -/
theorem emFieldStrength_antisymm (δ : Fin 3 → R → R) (A : Fin 3 → R) (j k : Fin 3) :
    emFieldStrength δ A j k = - emFieldStrength δ A k j := by
  simp only [emFieldStrength]; abel

/-- **Abelian gauge invariance (no Gribov ambiguity).**  Under the abelian gauge
transformation `A_j ↦ A_j + δ_j θ`, the abelian field strength is unchanged,
because the curl of a gradient vanishes (`δ_j (δ_k θ) = δ_k (δ_j θ)` by
commutativity of the partial derivatives). -/
theorem emFieldStrength_gauge_invariant
    (δ : Fin 3 → R → R) (A : Fin 3 → R) (θ : R)
    (hadd : ∀ j x y, δ j (x + y) = δ j x + δ j y)
    (hcomm : ∀ j k x, δ j (δ k x) = δ k (δ j x))
    (j k : Fin 3) :
    emFieldStrength δ (fun i => A i + δ i θ) j k = emFieldStrength δ A j k := by
  simp only [emFieldStrength, hadd]
  rw [hcomm j k θ]; abel

/-- **The `f = 0` reduction.**  When the connection components commute pairwise,
the non-abelian field strength `fieldStrengthMul` of
`ChapterYangMillsFieldStrength` (`F_{jk} = δ_j a_k - δ_k a_j + [a_j, a_k]`)
reduces to the abelian one, the quadratic `[a_j, a_k]` correction vanishing. -/
theorem fieldStrengthMul_eq_emFieldStrength_of_commute
    (δ : Fin 3 → R → R) (a : Fin 3 → R)
    (hcommute : ∀ j k, a j * a k = a k * a j) (j k : Fin 3) :
    fieldStrengthMul δ a j k = emFieldStrength δ a j k := by
  simp only [fieldStrengthMul, emFieldStrength, hcommute j k]; abel

end Abstract

section Coupling

variable {R : Type*} [Ring R] [Algebra ℂ R]

/-- **The `f = 0` reduction for the coupled field strength.**  When the gauge
potential components commute pairwise, the book's non-abelian field strength
`Fbook δ g A j k = (δ_j A_k - δ_k A_j) - i g [A_j, A_k]` reduces to the abelian
exterior derivative `δ_j A_k - δ_k A_j`. -/
theorem Fbook_eq_emFieldStrength_of_commute
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hcommute : ∀ j k, A j * A k = A k * A j) (j k : Fin 3) :
    Fbook δ g A j k = emFieldStrength δ A j k := by
  simp only [Fbook, emFieldStrength, hcommute j k, sub_self, smul_zero, sub_zero]

end Coupling

section SelfAdjoint

variable {R : Type*} [Ring R] [StarRing R]

/-- **The curl of self-adjoint operator fields is self-adjoint.**  If the partial
derivatives `δ_j` are `*`-preserving (`(δ_j x)* = δ_j (x*)`, as holds for genuine
derivations of a `*`-algebra) and each field component `π_i` is self-adjoint,
then every component of the field strength / curl `∂×π` is self-adjoint — the
book's *"local self-adjoint operator `∂×π`, the curl of the Electric Field"*. -/
theorem emFieldStrength_isSelfAdjoint
    (δ : Fin 3 → R → R) (π : Fin 3 → R)
    (hstar : ∀ (j : Fin 3) x, star (δ j x) = δ j (star x))
    (hsa : ∀ i, IsSelfAdjoint (π i)) (j k : Fin 3) :
    IsSelfAdjoint (emFieldStrength δ π j k) := by
  change star (δ j (π k) - δ k (π j)) = δ j (π k) - δ k (π j)
  rw [star_sub, hstar, hstar, (hsa k).star_eq, (hsa j).star_eq]

end SelfAdjoint

end BookProof.FreeEMField
