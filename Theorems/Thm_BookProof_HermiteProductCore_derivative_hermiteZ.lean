-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.derivative_hermiteZ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

product
Hermite core" is justified here: the products `∏ᵢ He_{αᵢ}(xᵢ)` of probabilists'
Hermite polynomials span the same space, because the three-term recurrence
`X · He_n = He_{n+1} + n · He_{n-1}` makes their span st := by sorry
