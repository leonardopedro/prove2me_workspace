import Mathlib
import BookProof.ChapterScalaronFockEsa
import BookProof.ChapterScalaronEdge

/-!
# The vielbein/TEGR fibrewise reassembly: shear fibers plus the scalaron fiber

`CONSOLIDATED_PLAN.md`, next-steps item **4(a)** of the 2026-08-28j block: *the explicit
fibrewise reassembly instance naming the TEGR shear fibers plus the scalaron fiber*, as thin
glue over the generic instrument `BookProof.ScalaronFock.fockSmoothPotential_esa`.

The vielbein (TEGR) gauge fixing of `docs/qg_starobinsky_vielbein_hamiltonian.cdb` gives each
quantum `d` shear field values `y₁, …, y_d` — per-mode harmonic fibers with constant positive
frequencies `ω₁, …, ω_d` — together with one scalaron field value `φ`, whose potential is
*exactly* the formalized Einstein-frame potential `starobinskyV`
(`BookProof.Starobinsky.starobinskyV`).  This module writes that fiber list down as an
explicit family of `n`-particle configuration sectors with an explicit `n`-particle
potential, and runs the generic direct-sum machinery on it.

## What is proved

* `vielbeinManyPotential` — the `n`-particle potential
  `∑ⱼ (∑ᵢ ½ωᵢ² yᵢ(j)² + V(φ(j)))` on the sector `ℝ^(n × (d+1))`, with
  `vielbeinManyPotential_apply` reading it off in coordinates and
  `vielbeinManyPotential_scalaron_fiber` identifying the last fiber of each quantum as the
  formalized scalaron potential.
* `contDiff_vielbeinManyPotential`, `vielbeinManyPotential_nonneg` — smoothness, and
  non-negativity for `0 < α` (the shear fibers are squares, the scalaron potential is a
  square: `starobinskyV_nonneg`).
* `vielbeinFock_symmetric`, `vielbeinFock_deficiencyTrivialAt`, **`vielbeinFock_esa`**,
  `vielbeinFock_stone_flow` — the reassembled operator on the nested Fock space
  `⊕ₙ L²(ℝ^(n × (d+1)))` is densely defined, symmetric, has trivial deficiency off the real
  axis, is essentially self-adjoint, and generates a complete unitary group.
* `vielbeinFock_potential_ge` — the uniform fibrewise lower bound `0` of the reassembled
  potential.

## Honest boundary

* What is unconditional: the reassembly itself — that the family "`d` harmonic shear fibers
  plus one Starobinsky scalaron fiber per quantum" produces an essentially self-adjoint
  multiplication operator on the nested Fock space, with a uniform lower bound.
* What stays a modelling statement: that this fiber list *is* the vielbein/TEGR gauge-fixed
  Hamiltonian's field content, and the values of the shear frequencies `ω`.  As elsewhere in
  the project, the TEGR kinetic/gravity sector is untouched; no mass gap of a physical
  Yang–Mills or gravity Hamiltonian is claimed here.
* This module is the *potential* half of the fiber reassembly, matching the generic
  instrument it glues (`fockSmoothPotentialOp` is multiplication by the `n`-particle
  potential).  The strict one-particle edge of the scalaron fiber, kinetic term included,
  is the separate theorem `BookProof.ScalaronEdge.starobinskyEdge_quadForm`.
-/

open Filter Topology MeasureTheory

namespace BookProof.VielbeinFock

open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The fiber list: `d` shear fibers and one scalaron fiber per quantum -/

/-- The `n`-particle configuration sector of the vielbein model: each of the `n` quanta
carries `d` TEGR shear field values (indices `0, …, d−1`) and one scalaron field value
(index `Fin.last d`). -/
abbrev vielbeinSector (d n : ℕ) := EuclideanSpace ℝ (Fin n × Fin (d + 1))

/-- The direction reading off the `i`-th field of the `j`-th quantum. -/
def vielbeinDir (d n : ℕ) (j : Fin n) (i : Fin (d + 1)) : vielbeinSector d n :=
  EuclideanSpace.single (j, i) (1 : ℝ)

lemma inner_vielbeinDir (d n : ℕ) (x : vielbeinSector d n) (j : Fin n) (i : Fin (d + 1)) :
    (inner ℝ x (vielbeinDir d n j i) : ℝ) = x (j, i) := by
  rw [vielbeinDir, EuclideanSpace.inner_single_right]
  simp

/-- The shear energy of a single quantum: the `d` harmonic TEGR shear fibers with the
per-mode frequencies `ω`. -/
def shearEnergy (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n) (x : vielbeinSector d n) : ℝ :=
  ∑ i : Fin d, om i ^ 2 / 2 * (inner ℝ x (vielbeinDir d n j i.castSucc) : ℝ) ^ 2

/-- **The many-body vielbein/TEGR potential**: for each quantum, the harmonic shear fibers
plus the Einstein-frame Starobinsky potential of its scalaron fiber. -/
def vielbeinManyPotential (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ)
    (x : vielbeinSector d n) : ℝ :=
  ∑ j : Fin n, (shearEnergy d om n j x
    + starobinskyV M alpha (inner ℝ x (vielbeinDir d n j (Fin.last d))))

lemma shearEnergy_apply (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n)
    (x : vielbeinSector d n) :
    shearEnergy d om n j x = ∑ i : Fin d, om i ^ 2 / 2 * (x (j, i.castSucc)) ^ 2 := by
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [inner_vielbeinDir]

lemma vielbeinManyPotential_apply (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ)
    (x : vielbeinSector d n) :
    vielbeinManyPotential M alpha d om n x
      = ∑ j : Fin n, ((∑ i : Fin d, om i ^ 2 / 2 * (x (j, i.castSucc)) ^ 2)
        + starobinskyV M alpha (x (j, Fin.last d))) := by
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [shearEnergy_apply, inner_vielbeinDir]

/-- **The scalaron fiber is exactly the formalized Starobinsky potential**: with no shear
fibers (`d = 0`) the many-body potential of the vielbein model is the sum over the quanta of
`starobinskyV`. -/
lemma vielbeinManyPotential_scalaron_fiber (M alpha : ℝ) (om : Fin 0 → ℝ) (n : ℕ)
    (x : vielbeinSector 0 n) :
    vielbeinManyPotential M alpha 0 om n x
      = ∑ j : Fin n, starobinskyV M alpha (x (j, Fin.last 0)) := by
  simp [vielbeinManyPotential_apply]

theorem contDiff_shearEnergy (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (shearEnergy d om n j) := by
  refine ContDiff.sum (fun i _ => ?_)
  have h : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      (fun x : vielbeinSector d n => (inner ℝ x (vielbeinDir d n j i.castSucc) : ℝ)) :=
    ((innerSL ℝ).flip (vielbeinDir d n j i.castSucc)).contDiff
  exact contDiff_const.mul (h.pow 2)

theorem contDiff_vielbeinManyPotential (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (vielbeinManyPotential M alpha d om n) :=
  ContDiff.sum (fun j _ =>
    (contDiff_shearEnergy d om n j).add (contDiff_scalaronAlong M alpha _))

theorem shearEnergy_nonneg (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n)
    (x : vielbeinSector d n) : 0 ≤ shearEnergy d om n j x :=
  Finset.sum_nonneg (fun i _ => by positivity)

/-- **The reassembled potential is non-negative**: the shear fibers are harmonic squares and
the scalaron fiber is a square (`starobinskyV_nonneg`). -/
theorem vielbeinManyPotential_nonneg {M alpha : ℝ} (halpha : 0 < alpha) (d : ℕ)
    (om : Fin d → ℝ) (n : ℕ) (x : vielbeinSector d n) :
    0 ≤ vielbeinManyPotential M alpha d om n x := by
  refine Finset.sum_nonneg (fun j _ => ?_)
  have h1 := shearEnergy_nonneg d om n j x
  have h2 := starobinskyV_nonneg (M := M) halpha
    (inner ℝ x (vielbeinDir d n j (Fin.last d)) : ℝ)
  linarith

/-- Essential self-adjointness of the reassembled potential on a single `n`-particle
sector. -/
theorem vielbeinManyPotential_esa (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn (ccDomain (vielbeinSector d n))
      (opCc (vielbeinManyPotential M alpha d om n)
        (contDiff_vielbeinManyPotential M alpha d om n)) :=
  smoothPotential_essentiallySelfAdjoint _ _

/-! ## 2. The reassembly on the nested Fock space -/

/-- **The nested Fock space of the vielbein model**, `⊕ₙ L²(ℝ^(n × (d+1)))`. -/
abbrev vielbeinFock (d : ℕ) := nestedFock (vielbeinSector d)

/-- The Fock core: the algebraic direct sum of the compactly supported smooth sector
cores. -/
abbrev vielbeinFockCore (d : ℕ) : Submodule ℂ (vielbeinFock d) := nestedCore (vielbeinSector d)

/-- **The second-quantised vielbein/TEGR potential** on the nested Fock space: on the
`n`-particle sector it is multiplication by `∑ⱼ (∑ᵢ ½ωᵢ² yᵢ(j)² + V(φ(j)))`. -/
def vielbeinFockHamiltonian (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    vielbeinFockCore d →ₗ[ℂ] vielbeinFock d :=
  fockSmoothPotentialOp (fun n => vielbeinManyPotential M alpha d om n)
    (fun n => contDiff_vielbeinManyPotential M alpha d om n)

theorem vielbeinFockCore_dense (d : ℕ) :
    Dense ((vielbeinFockCore d : Submodule ℂ (vielbeinFock d)) : Set (vielbeinFock d)) :=
  nestedCore_dense

theorem vielbeinFock_symmetric (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    SymmetricOn (vielbeinFockCore d) (vielbeinFockHamiltonian M alpha d om) :=
  fockSmoothPotential_symmetric _ _

theorem vielbeinFock_deficiencyTrivialAt (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) {z : ℂ}
    (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (vielbeinFockCore d) (vielbeinFockHamiltonian M alpha d om) z :=
  fockSmoothPotential_deficiencyTrivialAt _ _ hz

/-- **The vielbein/TEGR fiber reassembly is essentially self-adjoint on the nested Fock
space**: the shear fibers and the scalaron fiber are glued quantum by quantum and sector by
sector through `fockSmoothPotential_esa`. -/
theorem vielbeinFock_esa (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    EssentiallySelfAdjointOn (vielbeinFockCore d) (vielbeinFockHamiltonian M alpha d om) :=
  fockSmoothPotential_esa _ _

/-- **The complete unitary group `e^{−itH}` of the reassembled operator.** -/
theorem vielbeinFock_stone_flow (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (vielbeinFock d))
      (U : ℝ → (vielbeinFock d →L[ℂ] vielbeinFock d)),
      IsSelfAdjointExtension (vielbeinFockHamiltonian M alpha d om) T.op ∧ IsStoneFlow T U :=
  fockSmoothPotential_stone_flow (E := vielbeinSector d)
    (fun n => vielbeinManyPotential M alpha d om n)
    (fun n => contDiff_vielbeinManyPotential M alpha d om n)

/-- The uniform lower bound of the reassembled potential: `0`, in every particle sector. -/
theorem vielbeinFock_potential_ge {M alpha : ℝ} (halpha : 0 < alpha) (d : ℕ) (om : Fin d → ℝ)
    (n : ℕ) (x : vielbeinSector d n) : 0 ≤ vielbeinManyPotential M alpha d om n x :=
  vielbeinManyPotential_nonneg halpha d om n x

end

end BookProof.VielbeinFock
