-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsKoopmanOp_eq_subtype_comp
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution :
    nsKoopmanOp S = (polyGaussCore (d := d)).subtype ∘ₗ nsKoopmanCore S := rfl
