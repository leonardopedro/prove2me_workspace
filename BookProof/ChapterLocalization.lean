import Mathlib
import BookProof.ChapterA3

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Localization", **Proposition 88 / Corollary 1** — the algebraic localization obstruction

`book.tex` (§"Localization") proves **Proposition 88** ("for any complex localizable
unitary representation ... if it contains a positive energy representation then it also
contains the corresponding negative energy representation") and **Corollary 1** ("a
localizable Poincaré representation is an irreducible representation of the Poincaré group
including parity iff it is real and massive spin 1/2 or massless helicity 1/2").

Both proofs turn on a single concrete algebraic fact about the Majorana matrices:

> "the subspaces defined by the projectors involving the `iγ⁰`s ... are **not conserved**
> by the system of imprimitivity **because `γ⁰` does not commute with the matrices
> `γ⃗γ⁰`** present in the transformation from momenta to coordinate space."

Working in the concrete real Majorana model of `BookProof.ChapterA3` (`M_μ = iγ^μ`, so
`γ^μ = -i M_μ`), this file formalizes exactly that obstruction. Writing `A = iγ⁰` and, for
each spatial index `i ∈ {1,2,3}`, `B_i = (iγⁱ)(iγ⁰)` (the real Majorana image of `γⁱγ⁰`
up to a scalar), the commutator is computed in closed form:

  `[A, B_i] = A B_i − B_i A = 2 (iγⁱ) ≠ 0`.

The mechanism is the Clifford algebra: `{iγ⁰, iγⁱ} = 0` and `(iγ⁰)² = −1`, so
`A B_i = A (iγⁱ) A = −(iγⁱ) A² = iγⁱ` while `B_i A = (iγⁱ) A² = −iγⁱ`. Since `iγⁱ ≠ 0`,
`A` and `B_i` do **not** commute — the projector onto an `iγ⁰`-eigenspace is not preserved,
which is the crux of Prop 88 and Corollary 1.

The full statements of Prop 88 / Corollary 1 (systems of imprimitivity, direct-sum
decompositions of unitary Poincaré representations) are analytic and remain prose; this
file isolates their load-bearing algebraic core, decidably over the integer Majorana model
and then transported to the complex model.

This stays off the gravity line and off the Hankel-transform line, per the roadmap.
Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterLocalization

open BookProof.ChapterA3

/-! ### Integer model — the commutator `[iγ⁰, (iγⁱ)(iγ⁰)]` -/

/-- **The localization obstruction, integer model.** For every spatial index `i ≠ 0`,
the commutator of `iγ⁰` with `(iγⁱ)(iγ⁰)` equals `2 (iγⁱ)`:
`(iγ⁰)·((iγⁱ)(iγ⁰)) − ((iγⁱ)(iγ⁰))·(iγ⁰) = (iγⁱ) + (iγⁱ)`. -/
theorem commZ_gamma0_spatial (i : Fin 4) (hi : i ≠ 0) :
    mgammaZ 0 * (mgammaZ i * mgammaZ 0) - (mgammaZ i * mgammaZ 0) * mgammaZ 0
      = mgammaZ i + mgammaZ i := by
  revert i; decide

/-- The commutator `[iγ⁰, (iγⁱ)(iγ⁰)]` is nonzero for every spatial index `i ≠ 0`
(integer model), i.e. `iγ⁰` does **not** commute with `(iγⁱ)(iγ⁰)`. -/
theorem gamma0_not_comm_spatialZ (i : Fin 4) (hi : i ≠ 0) :
    mgammaZ 0 * (mgammaZ i * mgammaZ 0) ≠ (mgammaZ i * mgammaZ 0) * mgammaZ 0 := by
  revert i; decide

/-! ### Complex model — transport along the integer cast -/

/-- **The localization obstruction, complex model.** For every spatial index `i ≠ 0`,
`(iγ⁰)·((iγⁱ)(iγ⁰)) − ((iγⁱ)(iγ⁰))·(iγ⁰) = (iγⁱ) + (iγⁱ)`. -/
theorem comm_gamma0_spatial (i : Fin 4) (hi : i ≠ 0) :
    mgamma 0 * (mgamma i * mgamma 0) - (mgamma i * mgamma 0) * mgamma 0
      = mgamma i + mgamma i := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix (commZ_gamma0_spatial i hi)
  simpa only [map_sub, map_mul, map_add, mgamma] using h

/-- `iγ⁰` does **not** commute with `(iγⁱ)(iγ⁰)` for any spatial index `i ≠ 0`
(complex model) — the load-bearing algebraic fact behind Proposition 88 and Corollary 1. -/
theorem gamma0_not_comm_spatial (i : Fin 4) (hi : i ≠ 0) :
    mgamma 0 * (mgamma i * mgamma 0) ≠ (mgamma i * mgamma 0) * mgamma 0 := by
  intro h
  have hcomm := comm_gamma0_spatial i hi
  rw [h, sub_self] at hcomm
  -- `(iγⁱ) + (iγⁱ) = 0` forces `iγⁱ = 0`, contradicting `iγⁱ` unitary.
  have hi0 : mgamma i = 0 := by
    have h2 : mgamma i + mgamma i = 0 := hcomm.symm
    have : (2 : ℂ) • mgamma i = 0 := by rw [two_smul]; exact h2
    simpa using this
  -- but `iγⁱ` is unitary, hence nonzero
  have := mgamma_unitary i
  rw [hi0] at this
  simp at this

/-! ### The spatial rotation generators do commute with `iγ⁰`

The contrast that makes the little-group picture of Proposition 79 (massive case,
`G_l = SU(2)`) consistent: while the *boost*-type generators `(iγⁱ)(iγ⁰)` fail to
commute with `iγ⁰` (above), the *rotation* generators `(iγⁱ)(iγʲ)` with both indices
spatial **do** commute with `iγ⁰`, so they preserve the `iγ⁰`-eigenspaces and generate
the massive little group. -/

/-- Integer model: for spatial indices `i, j ≠ 0`, the rotation generator `(iγⁱ)(iγʲ)`
commutes with `iγ⁰`. -/
theorem commZ_gamma0_rotation (i j : Fin 4) (hi : i ≠ 0) (hj : j ≠ 0) :
    mgammaZ 0 * (mgammaZ i * mgammaZ j) = (mgammaZ i * mgammaZ j) * mgammaZ 0 := by
  revert i j; decide

/-- Complex model: for spatial indices `i, j ≠ 0`, the rotation generator `(iγⁱ)(iγʲ)`
commutes with `iγ⁰`. -/
theorem comm_gamma0_rotation (i j : Fin 4) (hi : i ≠ 0) (hj : j ≠ 0) :
    mgamma 0 * (mgamma i * mgamma j) = (mgamma i * mgamma j) * mgamma 0 := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix (commZ_gamma0_rotation i j hi hj)
  simpa only [map_mul, mgamma] using h

end BookProof.ChapterLocalization
