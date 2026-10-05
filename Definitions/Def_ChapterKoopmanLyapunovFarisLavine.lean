import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# Faris–Lavine for the Koopman generator of a polynomial vector field with a Lyapunov energy

For a polynomial vector field `G` on `ℝᵈ` with real coefficients, the Koopman–von Neumann
(Liouville) generator of its flow is the Weyl-ordered first-order operator

```
H_G = ½ Σ_i (π_i G_i + G_i π_i) = −i ( Σ_i G_i ∂_i + ½ div G ),        π_i = −i ∂_i .
```

This module proves, on the Gauss–polynomial core of `L²(ℝᵈ)` and for an **arbitrary** such `G`:

* `kvnGen_polySym`, `kvnGenOp_symmetricOn` — `H_G` is symmetric;
* `kvnGen_apply` — the formula above;
* `kvnGen_comm_mul` — for any polynomial `E`, `[H_G, E] = −i (G·∇E)`: the commutator of the
  generator with a multiplication operator is multiplication by the derivative of `E` along the
  flow;
* **`kvnGen_esa_of_lyapunov`** — the Faris–Lavine criterion with the comparison operator
  `N = H_G² + E`: if `E ≥ 0` is a real polynomial whose derivative along the flow is controlled,
  `|G·∇E| ≤ c E` pointwise, and `N` is essentially self-adjoint on the core, then `H_G` is
  essentially self-adjoint on the core.

This is the abstract form of `NsNonlinearFarisLavine.nsKoopman_esa_of_squareComparison_esa`
(which is the case `G = −νλu + B(u,u)`, `E = 1 + ‖u‖²`); the Lagrangian Navier–Stokes system of
`BookProof.ChapterNsLagrangianDetFarisLavine` is another instance.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.KoopmanLyapunov

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

/-- **The Koopman–von Neumann generator** `H_G = ½ Σ_i (π_i G_i + G_i π_i)` of a polynomial
vector field `G`. -/
def kvnGen (G : Fin d → MvPolynomial (Fin d) ℂ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  ∑ i, weylProd (momOp i) (mulOp (G i))







/-! ## On the Gauss–polynomial core -/

/-- `H_G` as a map of the Gauss–polynomial core into itself. -/
def kvnGenCore (G : Fin d → MvPolynomial (Fin d) ℂ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  (coreRepPoly d).op (kvnGen G)

/-- `H_G` on the Gauss–polynomial core of `L²(ℝᵈ)`. -/
def kvnGenOp (G : Fin d → MvPolynomial (Fin d) ℂ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ kvnGenCore G

/-- Multiplication by a polynomial on the Gauss–polynomial core. -/
def mulCoreOp (E : MvPolynomial (Fin d) ℂ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ (coreRepPoly d).op (mulOp E)













/-- **The comparison operator** `N = H_G² + E` on the Gauss–polynomial core. -/
def lyapunovComparison (G : Fin d → MvPolynomial (Fin d) ℂ) (E : MvPolynomial (Fin d) ℂ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  kvnGenOp G ∘ₗ kvnGenCore G + mulCoreOp E











end

end BookProof.KoopmanLyapunov
