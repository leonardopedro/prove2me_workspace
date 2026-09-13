-- Generated from ChapterSirkCertificateReader.lean — solution of BookProof.SirkCertificateReader.Decimal.toQ_nonneg
import Mathlib
import Definitions.Def_ChapterSirkCertificateReader
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertificateReader










open BookProof.SirkCertifiedGap

set_option maxHeartbeats 1000000 in
theorem solution {d : Decimal} (h : 0 ≤ d.mant) : 0 ≤ d.toQ := by

  have hp : (0 : ℚ) < (10 : ℚ) ^ d.exp := by positivity
  exact div_nonneg (by exact_mod_cast h) hp.le
