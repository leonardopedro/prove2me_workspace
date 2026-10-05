import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterVonNeumannCore
import Mathlib


/-!
# The polar decomposition as a genuine partial isometry, and its uniqueness

`BookProof.ChapterUnboundedPolar` proves `|Ā| = (A* Ā)^{1/2}`, `D(|Ā|) = D(Ā)`,
`‖ |Ā| x ‖ = ‖Ā x‖`, and — as an existence statement — a linear isometry `U` from
`ran |Ā|` onto `ran Ā` with `U (|Ā| x) = Ā x` (`exists_polar_isometry`).  That `U`
is only defined on the (not necessarily closed) range of `|Ā|`, it is not an
operator on `F`, and nothing is said about its uniqueness.

This module upgrades it to the classical statement.  Everything is done for a
general pair of linear maps with the same sesquilinear form and then applied.

## What is proved

Part 1 — the abstract construction.  For `P Q : Dom →ₗ[ℂ] F` with
`⟪P x, P y⟫ = ⟪Q x, Q y⟫` (equivalently `P* P = Q* Q`), write
`initSpace P = closure (ran P)`.  Then there is a **continuous** operator
`polarIsom P Q : F →L[ℂ] F` with

* `polarIsom_apply_range` : `U (P x) = Q x`;
* `norm_polarIsom` : `‖U z‖ = ‖p z‖` for every `z`, where `p` is the orthogonal
  projection onto `initSpace P` — so `U` is a **partial isometry** with initial
  space `closure (ran P)`;
* `polarIsom_eq_zero_of_mem_orthogonal` : `U` kills `(initSpace P)ᗮ`;
* `inner_polarIsom` and `adjoint_comp_polarIsom` : `U* U = p`;
* `polarIsom_mem_initSpace` and `polarIsom_comp_adjoint` : `U` maps into
  `closure (ran Q)` and `U U*` is the projection onto it — the final space;
* `adjoint_polarIsom_apply` : `U* (Q x) = P x`;
* `polarIsom_unique` : those two properties determine `U`.

Part 2 — the application to `Ā`.  `polarU A` is the partial isometry of the polar
decomposition of the closure `Ā`:

* **`polarU_absOn`** : `Ā x = U |Ā| x` — the polar decomposition;
* **`adjoint_polarU_clExt`** : `|Ā| x = U* Ā x`;
* `norm_polarU`, `polarU_eq_zero_of_mem_orthogonal`, `adjoint_comp_polarU`
  (`U* U` is the projection onto `closure (ran |Ā|)`) and `polarU_comp_adjoint`
  (`U U*` is the projection onto `closure (ran Ā)`);
* **`polarU_unique`** : `U` is the unique bounded operator that decomposes `Ā`
  and vanishes on the orthogonal complement of `closure (ran |Ā|)`;
* `absOn_eq_zero_iff` : `|Ā| x = 0 ↔ Ā x = 0` (the kernels agree).

Hypotheses: `F` is a complex Hilbert space, `A` symmetric on a dense domain `D`.
No invariance of the domain is used.
-/

namespace BookProof.PolarPartialIsometry

open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

/-! ## Part 1 — the abstract partial isometry -/

/-- The initial space of the partial isometry: the closure of `ran P`. -/
def initSpace (P : Dom →ₗ[ℂ] F) : Submodule ℂ F := (LinearMap.range P).topologicalClosure

theorem isClosed_initSpace (P : Dom →ₗ[ℂ] F) :
    IsClosed ((initSpace P : Submodule ℂ F) : Set F) :=
  Submodule.isClosed_topologicalClosure _

theorem range_le_initSpace (P : Dom →ₗ[ℂ] F) : LinearMap.range P ≤ initSpace P :=
  Submodule.le_topologicalClosure _

instance instCompleteSpaceInitSpace [CompleteSpace F] (P : Dom →ₗ[ℂ] F) :
    CompleteSpace (initSpace P) :=
  (isClosed_initSpace P).completeSpace_coe

section Abstract

variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))

/-- The isometry on `ran P` supplied by `ClosureUniqueness.exists_linearIsometry_of_inner_eq`. -/
noncomputable def preIsom : LinearMap.range P →ₗ[ℂ] F :=
  Classical.choose (exists_linearIsometry_of_inner_eq P Q h)



theorem norm_preIsom (z : LinearMap.range P) : ‖preIsom P Q h z‖ = ‖(z : F)‖ :=
  (Classical.choose_spec (exists_linearIsometry_of_inner_eq P Q h)).2.1 z

/-- The same isometry, as a continuous linear map. -/
noncomputable def preIsomL : LinearMap.range P →L[ℂ] F :=
  (preIsom P Q h).mkContinuous 1 (by
    intro z
    rw [norm_preIsom, one_mul]
    rfl)

@[simp] theorem preIsomL_apply (z : LinearMap.range P) : preIsomL P Q h z = preIsom P Q h z := rfl

/-- The inclusion of `ran P` into its closure, as a continuous linear map. -/
noncomputable def inclL : LinearMap.range P →L[ℂ] initSpace P :=
  (Submodule.inclusion (range_le_initSpace P)).mkContinuous 1 (by intro z; simp)

@[simp] theorem inclL_coe (z : LinearMap.range P) : ((inclL P z : initSpace P) : F) = (z : F) := rfl









variable [CompleteSpace F]

/-- **The partial isometry of the polar decomposition.** -/
noncomputable def polarIsom : F →L[ℂ] F :=
  ((preIsomL P Q h).extend (inclL P)).comp (initSpace P).orthogonalProjection





























end Abstract

/-! ## Part 2 — the polar decomposition of the closure `Ā` -/

section Application

variable [CompleteSpace F] {D : Submodule ℂ F} (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
  (hsym : SymmetricOn D A)

/-- **The partial isometry of the polar decomposition `Ā = U |Ā|`.** -/
noncomputable def polarU : F →L[ℂ] F :=
  polarIsom (absOn A hdense hsym) (clExt A hdense hsym) (inner_absOn A hdense hsym)

















end Application

end BookProof.PolarPartialIsometry
