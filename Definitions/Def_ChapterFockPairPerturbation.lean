import Definitions.Def_ChapterYangMillsFockGapChain
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# Chapter FockPairPerturbation — a *quadratic*, pair-creating unbounded perturbation

`ChapterFockFieldPerturbation` covers the coupling `Φ(f) = a†(f) + a(f)`, which is *linear*
in the creation/annihilation operators and changes the particle number by one.  The plan's
honest boundary recorded there is that Yang–Mills interaction terms are of higher degree in
the field, so the linear result does not reach them.

This chapter takes the next degree: the **pair operator**

  `P(f,g) = a†(f) a†(g) + a(g) a(f)`,

which is quadratic in the field, symmetric, unbounded, and changes the particle number by
*two* — it creates and destroys pairs, so neither the number-preserving lift of
`ChapterFockNumberPreservingGap` nor the bounded theory of
`ChapterFockInteractionStability` applies to it, and neither does the `N^{1/2}` estimate of
`ChapterFockFieldPerturbation`, which is not strong enough for a quadratic term.

## Deliverables

* `annA_creA` — the canonical commutation relation in the form
  `a_i a_j† = a_j† a_i + δ_ij`, and `annVec_creVec`, its vector form
  `a(g) a†(g) = a†(g) a(g) + ‖g‖²`;
* **`norm_creVec_sq`** — the resulting exact identity `‖a†(g)u‖² = ‖a(g)u‖² + ‖g‖²‖u‖²`, and
  **`norm_creVec_le`** — `‖a†(g)u‖ ≤ ‖g‖ (⟪u, N u⟫ + ‖u‖²)^{1/2}`, the `(N+1)^{1/2}` estimate
  that a quadratic term needs;
* **`abs_re_inner_pairVec_le`** — the form estimate
  `|Re⟪u, P(f,g)u⟫| ≤ 2‖f‖‖g‖ ⟪u,N u⟫^{1/2}(⟪u,N u⟫ + ‖u‖²)^{1/2}`;
* **`pairVec_relative_form_bound`** — the domination by the free form: on vacuum-orthogonal
  states, with a one-particle gap `h − μ ≥ 0` and `μ > 0`,
  `|Re⟪u, P(f,g)u⟫| ≤ (2√2‖f‖‖g‖/μ)·Re⟪u, dΓ(h)u⟫`.  Note the relative bound is
  *proportional to the coupling*, with no `‖u‖²` remainder: a pair term is form-bounded by
  the number operator with no additive constant on the vacuum-orthogonal sector;
* **`fock_gap_of_pair_perturbation`** — the conclusion: with `2√2‖f‖‖g‖ ≤ μ`, every
  vacuum-orthogonal finite-particle state has `dΓ(h) + P(f,g)` energy at least
  `(μ − 2√2‖f‖‖g‖)‖u‖²`; `fock_gap_of_pair_perturbation_pos` records strict positivity, and
  `fock_gap_of_one_particle_form_gap_pair` feeds it directly from the certificate chain's
  one-particle form gap;
* `pairVec_vac`, `pairVec_unbounded` — `P(f,g)` really does move the vacuum into the
  two-particle sector and really is unbounded;
* **`ym_fock_gap_of_pair_perturbation`** — the same conclusion for the concrete gauge-fixed
  Yang–Mills chain of `ChapterYangMillsFockGapChain`, conditional as always on the
  one-particle form gap on the Gauss–polynomial core.

## Honest boundary

`P(f,g)` is quadratic in the field.  The cubic and quartic Yang–Mills interaction terms are
still not covered, and the smallness condition `2√2‖f‖‖g‖ < μ` is a genuine restriction: a
large pair term can close the gap.  `1.932` remains a certified truncated number; no mass
gap of the physical Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockPairPerturbation

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

/-! ## 1. The canonical commutation relation in vector form -/



/-- The squared `ℓ²` norm of a finitely supported one-particle vector. -/
def l2sq (g : ℕ →₀ ℂ) : ℝ := ∑ j ∈ g.support, ‖g j‖ ^ 2







/-! ## 2. The `(N+1)^{1/2}` estimate for the creation operator -/







/-! ## 3. The pair operator and its form estimate -/

/-- **The pair operator** `P(f,g) = a†(f) a†(g) + a(g) a(f)`: quadratic in the field, and
changing the particle number by two. -/
def pairVec (f g : ℕ →₀ ℂ) : FockAlg →ₗ[ℂ] FockAlg :=
  (creVec f).comp (creVec g) + (annVec g).comp (annVec f)





/-! ## 4. The relative form bound and the surviving gap -/







/-! ## 5. Fed by the certificate chain -/

section FormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

open BookProof.HermiteGalerkin BookProof.FarisLavine



end FormGap

/-! ## 6. The perturbation is genuinely quadratic and genuinely unbounded -/











/-! ## 7. The gauge-fixed Yang–Mills instance -/

section YangMills

open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFockGapChain

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)



end YangMills

/-! ## 8. Axiom audit -/

section Audit

#print axioms annVec_creVec
#print axioms norm_creVec_sq
#print axioms norm_creVec_le
#print axioms abs_re_inner_pairVec_le
#print axioms pairVec_relative_form_bound
#print axioms fock_gap_of_pair_perturbation
#print axioms fock_gap_of_one_particle_form_gap_pair
#print axioms pairVec_vac
#print axioms pairVec_unbounded
#print axioms ym_fock_gap_of_pair_perturbation

end Audit

end BookProof.FockPairPerturbation

end
