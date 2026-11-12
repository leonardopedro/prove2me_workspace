-- Generated from ChapterQgOuterFockInteractionFL.lean — the `QgFamily`
-- relative-bound layer that the platform's served ChapterQgOuterFockInteractionFL
-- copy predates (§2.13 new-name route: submit-definition rejects an existing
-- name, so the decl lives here instead).  The served bundle stops at
-- `secExt`; `secExt_rel` is the Faris–Lavine relative bound the two
-- `esa_farisLavine` statements project as `F.secExt_rel`.
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_norm_le
import Mathlib

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

namespace BookProof.QgOuterFockInteractionFL

namespace QgFamily

variable (F : QgFamily)

/-- **The Faris–Lavine relative bound of the sector extension.**  The lifted
`n`-particle Hamiltonian `secExt n` is relatively bounded by the sector
comparison operator `harmFried (n * 84)` with the family's uniform constant
`flK` -- uniformly in `n`, which is exactly the input the `ℓ²`-direct-sum
Faris–Lavine theorem needs.  Inherited from the `CoreData` of the sector,
whose `rel` field is `secHam_norm_le`. -/
theorem secExt_rel : ∀ (n : ℕ) (u : (harmFried (n * 84)).dom),
    ‖F.secExt n u‖ ≤ F.flK * ‖(harmFried (n * 84)).op u + (u : L2d (n * 84))‖ :=
  fun n u => (F.secData n).ext_norm_le u

end QgFamily

end BookProof.QgOuterFockInteractionFL
