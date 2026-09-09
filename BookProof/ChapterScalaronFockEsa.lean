import Mathlib
import BookProof.ChapterScalaronCoreEsa
import BookProof.ChapterDirectSumEsa

/-!
# From one particle to the nested Fock space: the scalaron Hamiltonian in the continuum

Plan item **A5** (`CONSOLIDATED_PLAN.md` §10.5), closing step.  `ChapterScalaronCoreEsa`
proved essential self-adjointness of the gauge-fixed `R + αR²` Hamiltonian — conformal mode
plus the Einstein-frame **Starobinsky scalaron potential**, exponential wall and all — on a
dense core of the *one-particle* Hilbert space.  `ChapterDirectSumEsa` proved that essential
self-adjointness is fibrewise: a deficiency vector of an orthogonal direct sum, tested
against single-fibre states, has vanishing coordinates.

The state space of the quantised theory is a **nested Fock space** `⊕ₙ L²(Eₙ)`: the
`n`-particle sector carries the `n`-fold configuration space, and the Hamiltonian acts
sector by sector, the `n`-particle potential being the sum of the one-particle potentials of
the individual quanta.  This module links the two proved theorems and states the conclusion
on the Fock space itself.

## What is proved

**1. The generic instrument.**  For an arbitrary family `E : ℕ → Type*` of finite-dimensional
configuration sectors and an arbitrary family of *smooth* real potentials `W n : E n → ℝ` —
no growth, no boundedness, no semiboundedness — the operator `⊕ₙ W n` on the algebraic
direct sum `nestedCore` of the compactly supported smooth sector cores is densely defined
(`nestedCore_dense`), symmetric (`fockSmoothPotential_symmetric`), has trivial deficiency at
every non-real point (`fockSmoothPotential_deficiencyTrivialAt`), is essentially
self-adjoint (`fockSmoothPotential_esa`) and generates the complete unitary group
(`fockSmoothPotential_stone_flow`).

**2. The many-body scalaron potential.**  On the `n`-particle sector
`qgSector n = ℝ^(n × 2)` — each quantum carrying a conformal mode `R_c` and a scalaron `φ` —
the many-body gauge-fixed potential `∑ⱼ (V₃(R_c ⱼ) + V(φ ⱼ))` is smooth
(`contDiff_qgManyPotential`), bounded below by `−n·M⁴/(16α)` (`qgManyPotential_ge`) and
essentially self-adjoint on the sector core (`qgManyPotential_esa`).  At `n = 1` it *is* the
one-particle potential of `ChapterScalaronCoreEsa` (`qgManyPotential_one`).

**3. The Fock statement.**  `qgScalaronFockHamiltonian` is the second-quantised gauge-fixed
`R + αR²` Hamiltonian with the scalaron sector on the whole nested Fock space
`⊕ₙ L²(ℝ^(n×2))`; `qgScalaronFock_esa` is its essential self-adjointness and
`qgScalaronFock_stone_flow` the resulting global unitary group `e^{−itH}`.

**4. The same in the mode (Hermite) realisation** used by the gravity chapters, where the
one-particle result is `BookProof.ScalaronEsa.qgScalaronMode_esa`: the nested Fock space
`⊕ₙ L²(ℕ)` of finite-particle occupancies carries `qgScalaronModeFockHamiltonian`, which is
symmetric (`qgScalaronModeFock_symmetric`), essentially self-adjoint
(`qgScalaronModeFock_esa`) and generates the unitary group
(`qgScalaronModeFock_stone_flow`).

## Honest boundary

The gluing is over an *orthogonal* direct sum of sectors: the Hamiltonian is assumed to
preserve particle number, which is exactly the finite-particle (nested Fock) situation
described in the plan.  Nothing here adds an interaction that changes the sector, and
nothing here uses a direct integral over a continuous parameter.  The kinetic term is not
part of these statements — as in `ChapterScalaronCoreEsa`, the potential is the object whose
exponential growth was in question, and the wave-operator combination remains where that
module left it.
-/

open Filter Topology MeasureTheory SchwartzMap

namespace BookProof.ScalaronFock

open BookProof.FarisLavine BookProof.Starobinsky BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.QuantumGravityDensitized BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The nested Fock space over a family of configuration sectors -/

section Generic

variable {E : ℕ → Type*} [∀ n, NormedAddCommGroup (E n)] [∀ n, InnerProductSpace ℝ (E n)]
  [∀ n, FiniteDimensional ℝ (E n)] [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)]

/-- The `n`-particle sector `L²(Eₙ)`. -/
abbrev sector (E : ℕ → Type*) [∀ n, NormedAddCommGroup (E n)]
    [∀ n, InnerProductSpace ℝ (E n)] [∀ n, FiniteDimensional ℝ (E n)]
    [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)] (n : ℕ) :=
  Lp ℂ 2 (volume : Measure (E n))

/-- **The nested Fock space** `⊕ₙ L²(Eₙ)` of the finite-particle sectors. -/
abbrev nestedFock (E : ℕ → Type*) [∀ n, NormedAddCommGroup (E n)]
    [∀ n, InnerProductSpace ℝ (E n)] [∀ n, FiniteDimensional ℝ (E n)]
    [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)] :=
  lp (fun n : ℕ => sector E n) 2

/-- **The Fock core**: the algebraic direct sum of the compactly supported smooth cores of
the sectors. -/
def nestedCore (E : ℕ → Type*) [∀ n, NormedAddCommGroup (E n)]
    [∀ n, InnerProductSpace ℝ (E n)] [∀ n, FiniteDimensional ℝ (E n)]
    [∀ n, MeasurableSpace (E n)] [∀ n, BorelSpace (E n)] :
    Submodule ℂ (nestedFock E) :=
  dsCore (fun n => ccDomain (E n))

/-- **The Fock core is dense**: each sector core is dense (`ccDomain_dense`) and density of
an algebraic direct sum of dense fibre cores is `dsCore_dense`. -/
theorem nestedCore_dense :
    Dense ((nestedCore E : Submodule ℂ (nestedFock E)) : Set (nestedFock E)) :=
  dsCore_dense (fun _ => ccDomain_dense)

/-- **The second-quantised multiplication operator**: on the `n`-particle sector it is
multiplication by the `n`-particle potential `W n`. -/
def fockSmoothPotentialOp (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) :
    nestedCore E →ₗ[ℂ] nestedFock E :=
  dsOp (fun n => opCc (W n) (hW n))

theorem fockSmoothPotential_symmetric (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) :
    SymmetricOn (nestedCore E) (fockSmoothPotentialOp W hW) :=
  dsOp_symmetricOn _ (fun n => smoothPotential_symmetric (W n) (hW n))

/-- **The gluing step**, at a non-real point: fibrewise triviality of the deficiency space
(`smoothPotential_deficiencyTrivial`) glues to the Fock space. -/
theorem fockSmoothPotential_deficiencyTrivialAt (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (nestedCore E) (fockSmoothPotentialOp W hW) z :=
  dsOp_deficiencyTrivialAt _ (fun n => smoothPotential_deficiencyTrivial (W n) (hW n) hz)

/-- **Essential self-adjointness on the nested Fock space** for an arbitrary family of
smooth `n`-particle potentials: no growth, no boundedness, no semiboundedness. -/
theorem fockSmoothPotential_esa (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) :
    EssentiallySelfAdjointOn (nestedCore E) (fockSmoothPotentialOp W hW) :=
  dsOp_essentiallySelfAdjointOn _ (fun n => smoothPotential_essentiallySelfAdjoint (W n) (hW n))

set_option maxHeartbeats 1000000 in
-- unifying the Stone bridge with the `lp`-of-`Lp` direct sum is instance-heavy
/-- **The unitary flow on the nested Fock space.** -/
theorem fockSmoothPotential_stone_flow (W : ∀ n, E n → ℝ)
    (hW : ∀ n, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W n)) :
    ∃ (T : UnboundedSelfAdjoint (nestedFock E)) (U : ℝ → (nestedFock E →L[ℂ] nestedFock E)),
      IsSelfAdjointExtension (fockSmoothPotentialOp W hW) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (fockSmoothPotentialOp W hW) (nestedCore_dense (E := E))
    (fockSmoothPotential_symmetric W hW) (fockSmoothPotential_esa W hW)

end Generic

/-! ## 2. The many-body gauge-fixed `R + αR²` potential -/

/-- The `n`-particle configuration sector: each of the `n` quanta carries a conformal mode
`R_c` (index `0`) and a scalaron field value `φ` (index `1`). -/
abbrev qgSector (n : ℕ) := EuclideanSpace ℝ (Fin n × Fin 2)

/-- The direction reading off the `i`-th field of the `j`-th quantum. -/
def qgDir (n : ℕ) (j : Fin n) (i : Fin 2) : qgSector n :=
  EuclideanSpace.single (j, i) (1 : ℝ)

lemma inner_qgDir (n : ℕ) (x : qgSector n) (j : Fin n) (i : Fin 2) :
    (inner ℝ x (qgDir n j i) : ℝ) = x (j, i) := by
  rw [qgDir, EuclideanSpace.inner_single_right]
  simp

/-- **The many-body gauge-fixed `R + αR²` potential** on the `n`-particle sector: the sum
over the quanta of the one-particle potential `V₃(R_c) + V(φ)` of
`BookProof.ScalaronEsa.scalaronFullPotential`. -/
def qgManyPotential (M alpha : ℝ) (n : ℕ) (x : qgSector n) : ℝ :=
  ∑ j : Fin n, scalaronFullPotential M alpha (qgDir n j 0) (qgDir n j 1) x

lemma qgManyPotential_apply (M alpha : ℝ) (n : ℕ) (x : qgSector n) :
    qgManyPotential M alpha n x
      = ∑ j : Fin n, (confV M alpha (x (j, 0)) + starobinskyV M alpha (x (j, 1))) := by
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [scalaronFullPotential, inner_qgDir, inner_qgDir]

/-- At one particle the many-body potential is the one-particle potential of
`ChapterScalaronCoreEsa`. -/
lemma qgManyPotential_one (M alpha : ℝ) (x : qgSector 1) :
    qgManyPotential M alpha 1 x
      = scalaronFullPotential M alpha (qgDir 1 0 0) (qgDir 1 0 1) x := by
  simp [qgManyPotential]

theorem contDiff_qgManyPotential (M alpha : ℝ) (n : ℕ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (qgManyPotential M alpha n) :=
  ContDiff.sum (fun j _ => contDiff_scalaronFullPotential M alpha (qgDir n j 0) (qgDir n j 1))

/-- **The many-body potential is bounded below** by `−n·M⁴/(16α)`: each quantum contributes
a completed conformal parabola bounded by `−M⁴/(16α)` and a non-negative scalaron square. -/
theorem qgManyPotential_ge {M alpha : ℝ} (halpha : 0 < alpha) (n : ℕ) (x : qgSector n) :
    -(n * (M ^ 4 / (16 * alpha))) ≤ qgManyPotential M alpha n x := by
  have hterm : ∀ j : Fin n,
      -(M ^ 4 / (16 * alpha)) ≤ scalaronFullPotential M alpha (qgDir n j 0) (qgDir n j 1) x :=
    fun j => scalaronFullPotential_ge halpha _ _ x
  have hsum := Finset.sum_le_sum (fun j (_ : j ∈ Finset.univ) => hterm j)
  simpa [qgManyPotential, Finset.sum_const, nsmul_eq_mul, mul_comm] using hsum

/-- **Essential self-adjointness of the many-body potential on one sector.** -/
theorem qgManyPotential_esa (M alpha : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn (ccDomain (qgSector n))
      (opCc (qgManyPotential M alpha n) (contDiff_qgManyPotential M alpha n)) :=
  smoothPotential_essentiallySelfAdjoint _ _

/-! ## 3. The scalaron Hamiltonian on the nested Fock space -/

/-- **The nested Fock space of the scalaron sector**, `⊕ₙ L²(ℝ^(n×2))`. -/
abbrev qgFock := nestedFock qgSector

/-- The Fock core: the algebraic direct sum of the compactly supported smooth sector
cores. -/
abbrev qgFockCore : Submodule ℂ qgFock := nestedCore qgSector

/-- **The second-quantised gauge-fixed `R + αR²` Hamiltonian including the Starobinsky
scalaron potential**, on the nested Fock space: on the `n`-particle sector it is
multiplication by `∑ⱼ (V₃(R_c ⱼ) + V(φ ⱼ))`. -/
def qgScalaronFockHamiltonian (M alpha : ℝ) : qgFockCore →ₗ[ℂ] qgFock :=
  fockSmoothPotentialOp (fun n => qgManyPotential M alpha n)
    (fun n => contDiff_qgManyPotential M alpha n)

theorem qgFockCore_dense : Dense ((qgFockCore : Submodule ℂ qgFock) : Set qgFock) :=
  nestedCore_dense

theorem qgScalaronFock_symmetric (M alpha : ℝ) :
    SymmetricOn qgFockCore (qgScalaronFockHamiltonian M alpha) :=
  fockSmoothPotential_symmetric _ _

theorem qgScalaronFock_deficiencyTrivialAt (M alpha : ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt qgFockCore (qgScalaronFockHamiltonian M alpha) z :=
  fockSmoothPotential_deficiencyTrivialAt _ _ hz

/-- **The Starobinsky/`R + αR²` Hamiltonian is essentially self-adjoint on the nested Fock
space.**  This is the one-particle theorem `scalaronFullPotential_essentiallySelfAdjoint`
of `ChapterScalaronCoreEsa` carried to every finite-particle sector and glued by
`dsOp_essentiallySelfAdjointOn`. -/
theorem qgScalaronFock_esa (M alpha : ℝ) :
    EssentiallySelfAdjointOn qgFockCore (qgScalaronFockHamiltonian M alpha) :=
  fockSmoothPotential_esa _ _

/-- **The complete unitary group `e^{−itH}` on the nested Fock space.** -/
theorem qgScalaronFock_stone_flow (M alpha : ℝ) :
    ∃ (T : UnboundedSelfAdjoint qgFock) (U : ℝ → (qgFock →L[ℂ] qgFock)),
      IsSelfAdjointExtension (qgScalaronFockHamiltonian M alpha) T.op ∧ IsStoneFlow T U :=
  fockSmoothPotential_stone_flow (E := qgSector) (fun n => qgManyPotential M alpha n)
    (fun n => contDiff_qgManyPotential M alpha n)

/-! ## 4. The same in the mode (Hermite) realisation -/

section Modes

variable (a b : ℕ → ℕ → ℝ) (M alpha : ℝ) (Rc phi : ℕ → ℕ → ℝ)

/-- The `n`-particle core of the mode realisation: the maximal domain of the `n`-particle
mode symbol. -/
def modeSectorCore (n : ℕ) : Submodule ℂ L2Nat :=
  mulSymbolDomain (qgModeSymbol (a n) (b n) (qgScalaronModePotential M alpha (Rc n) (phi n)))

/-- **The nested Fock space of the mode realisation**, `⊕ₙ L²(ℕ)`. -/
abbrev modeFock := lp (fun _ : ℕ => L2Nat) 2

/-- The Fock core of the mode realisation. -/
def modeFockCore : Submodule ℂ (modeFock) := dsCore (modeSectorCore a b M alpha Rc phi)

/-- **The second-quantised `R + αR²` mode Hamiltonian with the scalaron sector.** -/
def qgScalaronModeFockHamiltonian :
    modeFockCore a b M alpha Rc phi →ₗ[ℂ] modeFock :=
  dsOp (fun n => qgScalaronModeHamiltonian (a n) (b n) M alpha (Rc n) (phi n))

theorem modeFockCore_dense :
    Dense ((modeFockCore a b M alpha Rc phi : Submodule ℂ modeFock) : Set modeFock) :=
  dsCore_dense (fun _ => mulSymbolDomain_dense _)

theorem qgScalaronModeFock_symmetric :
    SymmetricOn (modeFockCore a b M alpha Rc phi)
      (qgScalaronModeFockHamiltonian a b M alpha Rc phi) :=
  dsOp_symmetricOn _ (fun n => qgScalaronMode_symmetric (a n) (b n) M alpha (Rc n) (phi n))

theorem qgScalaronModeFock_deficiencyTrivialAt {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (modeFockCore a b M alpha Rc phi)
      (qgScalaronModeFockHamiltonian a b M alpha Rc phi) z :=
  dsOp_deficiencyTrivialAt _
    (fun n => qgScalaronMode_deficiencyTrivialAt (a n) (b n) M alpha (Rc n) (phi n) hz)

/-- **Essential self-adjointness of the mode Hamiltonian on the nested Fock space**: the
one-particle statement `qgScalaronMode_esa` holds in every finite-particle sector and glues
by `dsOp_essentiallySelfAdjointOn`. -/
theorem qgScalaronModeFock_esa :
    EssentiallySelfAdjointOn (modeFockCore a b M alpha Rc phi)
      (qgScalaronModeFockHamiltonian a b M alpha Rc phi) :=
  dsOp_essentiallySelfAdjointOn _
    (fun n => qgScalaronMode_esa (a n) (b n) M alpha (Rc n) (phi n))

/-- **The unitary group of the second-quantised mode Hamiltonian.** -/
theorem qgScalaronModeFock_stone_flow :
    ∃ (T : UnboundedSelfAdjoint modeFock) (U : ℝ → (modeFock →L[ℂ] modeFock)),
      IsSelfAdjointExtension (qgScalaronModeFockHamiltonian a b M alpha Rc phi) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (modeFockCore_dense a b M alpha Rc phi)
    (qgScalaronModeFock_symmetric a b M alpha Rc phi)
    (qgScalaronModeFock_esa a b M alpha Rc phi)

/-- The uniform lower bound of the many-particle mode potential: each sector is bounded
below by `−M⁴/(16α)`, the same constant as at one particle. -/
theorem qgScalaronModeFock_potential_ge (halpha : 0 < alpha) (n k : ℕ) :
    -(M ^ 4 / (16 * alpha)) ≤ qgScalaronModePotential M alpha (Rc n) (phi n) k :=
  qgScalaronMode_potential_ge M alpha (Rc n) (phi n) halpha k

end Modes

end

end BookProof.ScalaronFock
